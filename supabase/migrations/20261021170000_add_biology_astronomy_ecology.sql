-- Solara Olimp 1.1.0: support Biology, Astronomy and Ecology sessions.
alter table public.olimp_sessions
  drop constraint if exists olimp_sessions_code_check;
alter table public.olimp_sessions
  add constraint olimp_sessions_code_check
  check (code ~ '^[MIRPGHCBAE][A-HJ-NP-Z2-9]{5}$');

alter table public.olimp_sessions
  drop constraint if exists olimp_sessions_subject_check;
alter table public.olimp_sessions
  add constraint olimp_sessions_subject_check
  check (subject = any (array[
    'math','info','rus','physics','geography','history','chemistry',
    'biology','astronomy','ecology'
  ]::text[]));
