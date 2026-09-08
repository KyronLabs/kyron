import { BadRequestException, ConflictException } from '@nestjs/common';
import { Test } from '@nestjs/testing';
import { generateKeyPairSync, sign as signMessage } from 'node:crypto';
import { Prisma } from '@prisma/client';
import { IdentityService } from './identity.service';
import { didFromPublicKey } from './did-key';
import { PrismaService } from '../../infrastructure/prisma/prisma.service';

const ME = 'user-1';

function identity() {
  const { publicKey, privateKey } = generateKeyPairSync('ed25519');
  const raw = publicKey.export({ format: 'der', type: 'spki' }).subarray(-32);
  return {
    did: didFromPublicKey(raw),
    sign: (message: Buffer) =>
      signMessage(null, message, privateKey).toString('base64url'),
  };
}

describe('IdentityService', () => {
  const user = {
    update: jest.fn<Promise<unknown>, [unknown]>(),
    findUnique: jest.fn<Promise<{ did: string | null } | null>, [unknown]>(),
  };

  const service = async () => {
    const moduleRef = await Test.createTestingModule({
      providers: [
        IdentityService,
        { provide: PrismaService, useValue: { user } },
      ],
    }).compile();
    return moduleRef.get(IdentityService);
  };

  beforeEach(() => {
    jest.resetAllMocks();
    user.update.mockResolvedValue({});
  });

  // `resetAllMocks` clears calls but leaves a `spyOn` in place, and the
  // expiry test below spies on Date.now -- without this it stays wound
  // forward for every test after it.
  afterEach(() => jest.restoreAllMocks());

  /** Asks for a challenge and signs it as [who] would. */
  const prove = async (
    svc: IdentityService,
    who: ReturnType<typeof identity>,
    account = ME,
  ) => {
    const { challenge } = svc.issueChallenge(account);
    return who.sign(IdentityService.messageFor(account, challenge));
  };

  it('records the identifier once its key has signed the challenge', async () => {
    const svc = await service();
    const me = identity();

    await svc.claimDid(ME, me.did, await prove(svc, me));

    expect(user.update).toHaveBeenCalledWith({
      where: { id: ME },
      data: { did: me.did },
    });
  });

  it('refuses a claim nobody asked for a challenge for', async () => {
    const me = identity();
    const svc = await service();

    await expect(
      svc.claimDid(ME, me.did, me.sign(Buffer.from('anything'))),
    ).rejects.toThrow(BadRequestException);
    expect(user.update).not.toHaveBeenCalled();
  });

  it('refuses a signature by a key the identifier does not name', async () => {
    // Anyone can claim any identifier. This is the only thing that stops them.
    const svc = await service();
    const me = identity();
    const impostor = identity();
    const signature = await prove(svc, impostor);

    await expect(svc.claimDid(ME, me.did, signature)).rejects.toThrow(
      BadRequestException,
    );
    expect(user.update).not.toHaveBeenCalled();
  });

  it('refuses a signature made for another account', async () => {
    // The account id is inside the signed message, so a proof handed over by
    // somebody else does not transfer.
    const svc = await service();
    const me = identity();
    const theirChallenge = svc.issueChallenge('someone-else');
    const signature = me.sign(
      IdentityService.messageFor('someone-else', theirChallenge.challenge),
    );
    svc.issueChallenge(ME);

    await expect(svc.claimDid(ME, me.did, signature)).rejects.toThrow(
      BadRequestException,
    );
  });

  it('spends the challenge, so one cannot be used twice', async () => {
    const svc = await service();
    const me = identity();
    const signature = await prove(svc, me);

    await svc.claimDid(ME, me.did, signature);

    await expect(svc.claimDid(ME, me.did, signature)).rejects.toThrow(
      BadRequestException,
    );
  });

  it('spends the challenge on a failed attempt too', async () => {
    // Otherwise a live nonce stays up for as long as somebody keeps guessing.
    const svc = await service();
    const me = identity();
    const impostor = identity();
    const { challenge } = svc.issueChallenge(ME);

    await expect(
      svc.claimDid(
        ME,
        me.did,
        impostor.sign(IdentityService.messageFor(ME, challenge)),
      ),
    ).rejects.toThrow(BadRequestException);

    await expect(
      svc.claimDid(
        ME,
        me.did,
        me.sign(IdentityService.messageFor(ME, challenge)),
      ),
    ).rejects.toThrow(BadRequestException);
  });

  it('refuses one that has expired', async () => {
    const svc = await service();
    const me = identity();
    const { challenge } = svc.issueChallenge(ME);
    const signature = me.sign(IdentityService.messageFor(ME, challenge));

    jest
      .spyOn(Date, 'now')
      .mockReturnValue(Date.now() + IdentityService.challengeTtlMs + 1);

    await expect(svc.claimDid(ME, me.did, signature)).rejects.toThrow(
      BadRequestException,
    );
  });

  it('keeps only the latest challenge for an account', async () => {
    // Asking twice must not leave two live nonces to answer.
    const svc = await service();
    const me = identity();
    const first = svc.issueChallenge(ME);
    svc.issueChallenge(ME);

    await expect(
      svc.claimDid(
        ME,
        me.did,
        me.sign(IdentityService.messageFor(ME, first.challenge)),
      ),
    ).rejects.toThrow(BadRequestException);
  });

  it('says so when the identifier belongs to somebody else', async () => {
    // An identifier two accounts hold identifies neither.
    const svc = await service();
    const me = identity();
    user.update.mockRejectedValue(
      new Prisma.PrismaClientKnownRequestError('taken', {
        code: 'P2002',
        clientVersion: 'test',
      }),
    );

    await expect(
      svc.claimDid(ME, me.did, await prove(svc, me)),
    ).rejects.toThrow(ConflictException);
  });

  it('gives a challenge that expires and is not guessable', async () => {
    const svc = await service();

    const a = svc.issueChallenge(ME);
    const b = svc.issueChallenge('other');

    expect(a.challenge).not.toEqual(b.challenge);
    // 32 bytes of base64url.
    expect(a.challenge).toHaveLength(43);
    expect(Date.parse(a.expiresAt)).toBeGreaterThan(Date.now());
  });

  it('reports no identifier when the account has not made one', async () => {
    const svc = await service();
    user.findUnique.mockResolvedValue({ did: null });

    await expect(svc.didFor(ME)).resolves.toEqual({ did: null });
  });
});
