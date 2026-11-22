import { PrismaService } from '../prisma/prisma.service';
import { LegacyCoinReconciliationService } from '../../modules/financial-ledger/legacy-coin-reconciliation.service';

async function main(): Promise<void> {
  const prisma = new PrismaService();

  try {
    await prisma.$connect();
    const includeUserBalances = process.argv.includes(
      '--include-user-balances',
    );
    const report = await new LegacyCoinReconciliationService(
      prisma,
    ).dryRun({ includeUserBalances });

    console.log(JSON.stringify(report, null, 2));
    if (report.summary.issues.blockers > 0) {
      console.error(
        `Dry run found ${report.summary.issues.blockers} blocking reconciliation issue(s). No ledger rows were written.`,
      );
      process.exitCode = 2;
    } else {
      console.error(
        `Dry run complete: ${report.summary.newTransactions} proposed transaction(s), no ledger rows written.`,
      );
    }
  } finally {
    await prisma.$disconnect();
  }
}

main().catch((error: unknown) => {
  console.error(
    'Legacy coin reconciliation dry run failed:',
    error instanceof Error ? error.message : String(error),
  );
  process.exitCode = 1;
});
