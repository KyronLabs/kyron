import { ConflictException } from '@nestjs/common';
import { CreatorWithdrawalStatus } from '@prisma/client';
import { CreatorWithdrawalsService } from './creator-withdrawals.service';

describe('CreatorWithdrawalsService dual-control approval', () => {
  const withdrawal = {
    id: '33333333-3333-4333-8333-333333333333',
    status: CreatorWithdrawalStatus.REQUESTED,
    approvalRequestId: null,
    approvalRequestedById: null,
    approvalRequestedAt: null,
    approvedById: null,
    approvedAt: null,
  };

  const createHarness = () => {
    const tx = {
      $queryRaw: jest.fn(),
      creatorWithdrawal: {
        findUnique: jest.fn(),
        update: jest.fn(),
      },
      financialAuditEvent: {
        create: jest.fn().mockResolvedValue({}),
      },
    };
    tx.creatorWithdrawal.findUnique.mockResolvedValue({ ...withdrawal });
    tx.creatorWithdrawal.update.mockImplementation(
      ({ data }: { data: Record<string, unknown> }) =>
        Promise.resolve({ ...withdrawal, ...data }),
    );
    const prisma = {
      $transaction: jest.fn((callback: (transaction: typeof tx) => unknown) =>
        callback(tx),
      ),
    };
    const service = new CreatorWithdrawalsService(
      prisma as never,
      {} as never,
      {} as never,
      {} as never,
    );
    return { service, tx };
  };

  it('records the first administrator without approving the withdrawal', async () => {
    const { service, tx } = createHarness();

    await service.requestApproval({
      withdrawalId: withdrawal.id,
      actorId: 'admin-requester',
      requestId: 'withdrawal-approval-01',
    });

    expect(tx.$queryRaw).toHaveBeenCalled();
    expect(tx.creatorWithdrawal.update).toHaveBeenCalledWith({
      where: { id: withdrawal.id },
      data: expect.objectContaining({
        approvalRequestId: 'withdrawal-approval-01',
        approvalRequestedById: 'admin-requester',
        approvalRequestedAt: expect.any(Date),
      }),
    });
    expect(tx.financialAuditEvent.create).toHaveBeenCalledWith({
      data: expect.objectContaining({
        actorId: 'admin-requester',
        eventType: 'CREATOR_WITHDRAWAL_APPROVAL_REQUESTED',
        requestId: 'withdrawal-approval-01',
      }),
    });
  });

  it('rejects approval by the administrator who requested it', async () => {
    const { service, tx } = createHarness();
    tx.creatorWithdrawal.findUnique.mockResolvedValue({
      ...withdrawal,
      approvalRequestId: 'withdrawal-approval-01',
      approvalRequestedById: 'admin-requester',
      approvalRequestedAt: new Date(),
    });

    await expect(
      service.approve(
        withdrawal.id,
        'admin-requester',
        'withdrawal-approval-01',
      ),
    ).rejects.toBeInstanceOf(ConflictException);
    expect(tx.creatorWithdrawal.update).not.toHaveBeenCalled();
    expect(tx.financialAuditEvent.create).not.toHaveBeenCalled();
  });

  it('allows a different administrator and audits both identities', async () => {
    const { service, tx } = createHarness();
    tx.creatorWithdrawal.findUnique.mockResolvedValue({
      ...withdrawal,
      approvalRequestId: 'withdrawal-approval-01',
      approvalRequestedById: 'admin-requester',
      approvalRequestedAt: new Date(),
    });

    await service.approve(
      withdrawal.id,
      'admin-approver',
      'withdrawal-approval-01',
    );

    expect(tx.creatorWithdrawal.update).toHaveBeenCalledWith({
      where: { id: withdrawal.id },
      data: expect.objectContaining({
        status: CreatorWithdrawalStatus.APPROVED,
        approvedById: 'admin-approver',
        approvedAt: expect.any(Date),
      }),
    });
    expect(tx.financialAuditEvent.create).toHaveBeenCalledWith({
      data: expect.objectContaining({
        actorId: 'admin-approver',
        eventType: 'CREATOR_WITHDRAWAL_APPROVED',
        requestId: 'withdrawal-approval-01',
        metadata: expect.objectContaining({
          approvalRequestedById: 'admin-requester',
          approvedById: 'admin-approver',
        }),
      }),
    });
  });

  it('requires the exact approval request key', async () => {
    const { service, tx } = createHarness();
    tx.creatorWithdrawal.findUnique.mockResolvedValue({
      ...withdrawal,
      approvalRequestId: 'withdrawal-approval-01',
      approvalRequestedById: 'admin-requester',
      approvalRequestedAt: new Date(),
    });

    await expect(
      service.approve(withdrawal.id, 'admin-approver', 'another-request-02'),
    ).rejects.toBeInstanceOf(ConflictException);
  });
  it('returns the existing approval on an identical retry', async () => {
    const { service, tx } = createHarness();
    tx.creatorWithdrawal.findUnique.mockResolvedValue({
      ...withdrawal,
      status: CreatorWithdrawalStatus.APPROVED,
      approvalRequestId: 'withdrawal-approval-01',
      approvalRequestedById: 'admin-requester',
      approvalRequestedAt: new Date(),
      approvedById: 'admin-approver',
      approvedAt: new Date(),
    });

    const result = await service.approve(
      withdrawal.id,
      'admin-approver',
      'withdrawal-approval-01',
    );

    expect(result.status).toBe(CreatorWithdrawalStatus.APPROVED);
    expect(tx.creatorWithdrawal.update).not.toHaveBeenCalled();
    expect(tx.financialAuditEvent.create).not.toHaveBeenCalled();
  });

});
