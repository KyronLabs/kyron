-- deliver_push, handle_new_user and notify_on_reply are SECURITY DEFINER
-- trigger functions. They were reachable over PostgREST as
-- /rest/v1/rpc/<name> by both anon and authenticated callers.
--
-- deliver_push is the sharpest edge: it reads service_role_key out of the
-- vault to sign an outbound http_post, so it must never be caller-invocable.
--
-- PostgreSQL checks EXECUTE on a trigger function at CREATE TRIGGER time,
-- not on each fire, so revoking here does not affect the attached triggers
-- (notifications_deliver_push, on_auth_user_created, news_replies_notify).

revoke execute on function public.deliver_push()    from public, anon, authenticated;
revoke execute on function public.handle_new_user() from public, anon, authenticated;
revoke execute on function public.notify_on_reply() from public, anon, authenticated;
