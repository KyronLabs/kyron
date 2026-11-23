-- Google Play purchase processing and purchased-coin wallet movements.
-- The token remains encrypted and the lookup digest remains globally unique.
ALTER TYPE "CoinKind" ADD VALUE IF NOT EXISTS 'PURCHASE_GRANT';
ALTER TYPE "CoinKind" ADD VALUE IF NOT EXISTS 'PURCHASE_SPEND';

ALTER TABLE "GooglePlayPurchase"
  ADD COLUMN "purchaseCurrencyCode" CHAR(3),
  ADD COLUMN "grossAmountNanos" BIGINT,
  ADD COLUMN "developerRevenueNanos" BIGINT;

ALTER TABLE "GooglePlayPurchase"
  ADD CONSTRAINT "GooglePlayPurchase_currency_code_valid"
    CHECK (
      "purchaseCurrencyCode" IS NULL
      OR "purchaseCurrencyCode" ~ '^[A-Z]{3}$'
    ),
  ADD CONSTRAINT "GooglePlayPurchase_gross_amount_positive"
    CHECK ("grossAmountNanos" IS NULL OR "grossAmountNanos" > 0),
  ADD CONSTRAINT "GooglePlayPurchase_developer_revenue_nonnegative"
    CHECK ("developerRevenueNanos" IS NULL OR "developerRevenueNanos" >= 0);
