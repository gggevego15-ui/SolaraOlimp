-- Allow all subjects currently supported by the Solara Olimp frontend/API.
alter table public.olimp_sessions
  drop constraint if exists olimp_sessions_code_check;

alter table public.olimp_sessions
  add constraint olimp_sessions_code_check
  check (code ~ '^[MIRPGHC][A-HJ-NP-Z2-9]{5}$');

alter table public.olimp_sessions
  drop constraint if exists olimp_sessions_subject_check;

alter table public.olimp_sessions
  add constraint olimp_sessions_subject_check
  check (subject = any (array['math','info','rus','physics','geography','history','chemistry']::text[]));
