-- Reward-funded gifts produce withdrawable creator earnings, on the
-- same terms as purchase-funded gifts. Keep a distinct ledger kind solely
-- for source attribution and reconciliation.
ALTER TYPE "CoinKind" ADD VALUE 'REWARD_EARN';
