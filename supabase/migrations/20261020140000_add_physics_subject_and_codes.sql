alter table public.olimp_sessions
  drop constraint if exists olimp_sessions_subject_check;

alter table public.olimp_sessions
  add constraint olimp_sessions_subject_check
  check (subject = any (array['math'::text, 'info'::text, 'rus'::text, 'physics'::text]));

alter table public.olimp_sessions
  drop constraint if exists olimp_sessions_code_check;

alter table public.olimp_sessions
  add constraint olimp_sessions_code_check
  check (code ~ '^[MIRP][A-HJ-NP-Z2-9]{5}$'::text);
