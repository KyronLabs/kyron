-- Harden API-owned financial trigger functions and remove obsolete client
-- grants without changing ledger semantics, balances or existing public RPCs.
-- Run as the Prisma migration owner (postgres on the hosted database).
BEGIN;

ALTER FUNCTION public."kyron_assert_creator_earning_reservation_total"() SET search_path = pg_catalog, public, pg_temp;
REVOKE EXECUTE ON FUNCTION public."kyron_assert_creator_earning_reservation_total"() FROM PUBLIC, anon, authenticated;

ALTER FUNCTION public."kyron_assert_ledger_transaction_balanced"() SET search_path = pg_catalog, public, pg_temp;
REVOKE EXECUTE ON FUNCTION public."kyron_assert_ledger_transaction_balanced"() FROM PUBLIC, anon, authenticated;

ALTER FUNCTION public."kyron_protect_creator_earning_hold"() SET search_path = pg_catalog, public, pg_temp;
REVOKE EXECUTE ON FUNCTION public."kyron_protect_creator_earning_hold"() FROM PUBLIC, anon, authenticated;

ALTER FUNCTION public."kyron_protect_creator_earning_reservation"() SET search_path = pg_catalog, public, pg_temp;
REVOKE EXECUTE ON FUNCTION public."kyron_protect_creator_earning_reservation"() FROM PUBLIC, anon, authenticated;

ALTER FUNCTION public."kyron_protect_fx_quote"() SET search_path = pg_catalog, public, pg_temp;
REVOKE EXECUTE ON FUNCTION public."kyron_protect_fx_quote"() FROM PUBLIC, anon, authenticated;

ALTER FUNCTION public."kyron_protect_ledger_account_identity"() SET search_path = pg_catalog, public, pg_temp;
REVOKE EXECUTE ON FUNCTION public."kyron_protect_ledger_account_identity"() FROM PUBLIC, anon, authenticated;

ALTER FUNCTION public."kyron_protect_payout_provider_event"() SET search_path = pg_catalog, public, pg_temp;
REVOKE EXECUTE ON FUNCTION public."kyron_protect_payout_provider_event"() FROM PUBLIC, anon, authenticated;

ALTER FUNCTION public."kyron_reject_financial_evidence_mutation"() SET search_path = pg_catalog, public, pg_temp;
REVOKE EXECUTE ON FUNCTION public."kyron_reject_financial_evidence_mutation"() FROM PUBLIC, anon, authenticated;

ALTER FUNCTION public."kyron_require_same_xact_for_ledger_posting"() SET search_path = pg_catalog, public, pg_temp;
REVOKE EXECUTE ON FUNCTION public."kyron_require_same_xact_for_ledger_posting"() FROM PUBLIC, anon, authenticated;

REVOKE ALL ON SEQUENCE public."Feedback_number_seq" FROM PUBLIC, anon, authenticated;

-- Per-schema defaults cannot remove PostgreSQL's global PUBLIC EXECUTE
-- default. Revoke that default globally for the migration owner only.
-- This does not change existing function grants or managed platform roles.
ALTER DEFAULT PRIVILEGES REVOKE EXECUTE ON FUNCTIONS FROM PUBLIC;
ALTER DEFAULT PRIVILEGES IN SCHEMA public
  REVOKE EXECUTE ON FUNCTIONS FROM PUBLIC, anon, authenticated;
ALTER DEFAULT PRIVILEGES IN SCHEMA public
  REVOKE ALL ON SEQUENCES FROM PUBLIC, anon, authenticated;
ALTER DEFAULT PRIVILEGES IN SCHEMA public
  REVOKE ALL ON TABLES FROM PUBLIC, anon, authenticated;

-- Fail the migration rather than report success with residual client access.
DO $$
DECLARE
  fn regprocedure;
BEGIN
  FOREACH fn IN ARRAY ARRAY[
    'public."kyron_assert_creator_earning_reservation_total"()'::regprocedure,
    'public."kyron_assert_ledger_transaction_balanced"()'::regprocedure,
    'public."kyron_protect_creator_earning_hold"()'::regprocedure,
    'public."kyron_protect_creator_earning_reservation"()'::regprocedure,
    'public."kyron_protect_fx_quote"()'::regprocedure,
    'public."kyron_protect_ledger_account_identity"()'::regprocedure,
    'public."kyron_protect_payout_provider_event"()'::regprocedure,
    'public."kyron_reject_financial_evidence_mutation"()'::regprocedure,
    'public."kyron_require_same_xact_for_ledger_posting"()'::regprocedure
  ]
  LOOP
    IF has_function_privilege('anon', fn, 'EXECUTE')
       OR has_function_privilege('authenticated', fn, 'EXECUTE') THEN
      RAISE EXCEPTION 'Financial trigger still grants client execution: %', fn;
    END IF;
    IF NOT EXISTS (
      SELECT 1 FROM pg_proc p
      WHERE p.oid = fn AND NOT p.prosecdef
        AND p.prorettype = 'trigger'::regtype
        AND 'search_path=pg_catalog, public, pg_temp' = ANY(p.proconfig)
    ) THEN
      RAISE EXCEPTION 'Financial trigger search path or security mode is unsafe: %', fn;
    END IF;
  END LOOP;
  IF has_sequence_privilege('anon', 'public."Feedback_number_seq"', 'SELECT,USAGE,UPDATE')
     OR has_sequence_privilege('authenticated', 'public."Feedback_number_seq"', 'SELECT,USAGE,UPDATE') THEN
    RAISE EXCEPTION 'Feedback sequence still grants client access';
  END IF;
END
$$;

COMMIT;
