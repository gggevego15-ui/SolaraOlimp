# Ручная проверка учителей Solara Olimp

Заявки доступны только через серверную Edge Function. Таблицы закрыты для ролей `anon` и `authenticated`; проверку и выдачу кодов выполняет администратор через Supabase SQL Editor.

## 1. Посмотреть заявки, ожидающие проверки

```sql
select id, teacher_name, school_name, school_email, proof_url, notes, created_at
from public.olimp_teacher_verification_requests
where status = 'pending'
order by created_at asc;
```

Открой ссылку на официальный сайт учреждения и проверь соответствие имени и рабочей почты. Не проси присылать паспорт или другие документы с чувствительными данными.

## 2. Одобрить заявку и создать код доступа

Сгенерируй длинный случайный код вне сайта, передай его подтверждённому учителю отдельно и замени значения-заполнители в запросе ниже. Код хранится в базе только в виде SHA-256-хеша.

```sql
begin;

update public.olimp_teacher_verification_requests
set status = 'approved', reviewed_at = now()
where id = 'PASTE-REQUEST-UUID-HERE'
  and status = 'pending';

insert into public.olimp_teacher_access_codes (code_hash, teacher_email)
values (
  encode(digest('PASTE-STRONG-RANDOM-CODE-HERE', 'sha256'), 'hex'),
  lower('teacher@school.example')
);

commit;
```

Убедись, что запрос на обновление изменил ровно одну строку и что почта совпадает с проверенной заявкой. Никогда не помещай код доступа в HTML, GitHub или публичные сообщения.

## 3. Отклонить заявку или отозвать доступ

Отклонить заявку:

```sql
update public.olimp_teacher_verification_requests
set status = 'rejected', reviewed_at = now()
where id = 'PASTE-REQUEST-UUID-HERE'
  and status = 'pending';
```

Отозвать ранее выданный код:

```sql
update public.olimp_teacher_access_codes
set active = false
where teacher_email = lower('teacher@school.example');
```

Отозванный код перестанет работать при следующей проверке и при создании занятия.

## Важно

- Заявки проверяются вручную; сайт не отправляет автоматическое письмо с результатом.
- Не выдавай коды до проверки официальной страницы учреждения.
- Код доступа подтверждает допуск к кабинету, но не заменяет разумную проверку личности заявителя.
