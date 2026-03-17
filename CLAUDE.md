# Kurdyuk Lite Operating Contract

Ты работаешь в режиме **Kurdyuk Lite**.

Цель: провести задачу через короткий, жёсткий pipeline:
**Discovery -> Research -> Plan -> Annotate (1-6x) -> Readiness -> Implement -> Final Review**.

## Главные правила

1. **Всегда сначала читай `state.md`.**
2. Если `.kurdyuk-lite/runs/<project-slug>/` не существует — создай его из шаблонов в `.kurdyuk-lite/templates/`.
3. Не начинай код, пока `implementation-readiness.md` не имеет verdict `pass`.
4. `plan.md` — канонический implementation contract.
5. `todo.md` — единственная execution surface. Прогресс отмечай там (`□ -> ✅`).
6. **Verification:** не отмечай задачу ✅ без proof (тест прошёл, лог корректный, скриншот). Заполни поле `**Verify:**` в задаче результатом проверки.
7. Не переводи работу в финальный review, пока все обязательные задачи в `todo.md` не закрыты.
8. Если по пути всплыл material change — обнови `brief.md`, `intent.md`, `invariants.md`, `research.md` или `plan.md` явно. Не делай тихую подмену смысла.
9. Держи процесс коротким. Не плодить decorative docs.
10. **Phase gate:** после завершения каждой фазы покажи результат и дождись подтверждения пользователя перед переходом к следующей. Не перескакивай фазы молча. Порядок gates: Discovery ✓ → Research ✓ → Plan ✓ → Readiness ✓ → Implement ✓ → Final Review.

## Discovery floor

Перед research зафиксируй 4 вещи:

- что строим;
- для кого;
- что НЕ строим;
- что считается первым успехом.

Правила:

- максимум 1 вопрос за сообщение;
- максимум 3 вопроса, если задача простая;
- обязательно предложи **1 recommended approach** и **1 alternative**;
- если вход слабый — скажи это прямо.

## Working file order

1. `state.md`
2. `brief.md`
3. `intent.md`
4. `invariants.md`
5. `research.md`
6. `plan.md`
7. `todo.md`
8. `implementation-readiness.md`
9. `final-review.md`

## Annotation Cycle (между Plan и Readiness)

Annotation cycle — это **агентные проходы** по `plan.md`, не ручные правки пользователя в редакторе. Каждый проход = специализированный агент читает план и возвращает коррекции. Claude применяет коррекции, показывает diff, спрашивает про следующий цикл.

### Типовые агентные проходы (порядок свободный)

- **Red Team** — атакует план: scope creep, wrong assumptions, failure modes
- **Architect** — архитектурные trade-offs, structural issues
- **Codex (implementation reviewer)** — Claude запускает через Bash:
  ```bash
  codex exec "Review plan.md as implementation expert: check feasibility, find pitfalls, compare with brief.md for scope drift. Be direct." \
    --sandbox read-only -m o4-mini \
    -C .kurdyuk-lite/runs/<slug>/ -o /tmp/codex-plan-review.md
  # <slug> берётся из поля Slug в state.md
  ```
  Затем читает `/tmp/codex-plan-review.md` и применяет к plan.md.
- **Пользователь** — продуктовые коррекции ("убери регистрацию", "сделай проще")

### Правила

- 1–6 итераций — нормально;
- Claude читает вывод агентов, обновляет plan.md, показывает diff;
- пока пользователь не сказал "plan OK" — implement запрещён;
- **после каждого цикла** спроси явно: "Нужен ещё цикл или план готов?" — не решай сам;
- Codex запускается **один раз** в начале annotation (до первого цикла). Повторно — только по явному запросу "перезапусти codex".

## API Skill Generation

Когда на **любом этапе pipeline** появляется внешний API — **создай native skill** в `~/.claude/skills/<api-name>/SKILL.md`.

Правила:

- **Когда:** как только внешний API появился в scope. Чем раньше — тем лучше.
- Проверь существующие skills (`~/.claude/skills/`) — не дублируй.
- **Что фиксировать:** base URL, auth, rate limits, endpoints (request/response), pricing, gotchas.
- **Frontmatter:** `name`, `description` (retrieval key!), `user-invocable: false`.
- **Источник:** официальная документация API (fetch + read), не память модели.
- **Freshness:** `volatile` API — проверять VERIFIED при каждом использовании. `stable` — раз в месяц.

## Session strategy

Pipeline — **session-agnostic**. Файлы в `.kurdyuk-lite/runs/<slug>/` — единственный надёжный handoff-механизм. Длинная сессия не даёт преимущества: при заполнении контекста compression съедает неявный контекст так же, как смена сессии.

Правила:

- `state.md` — точка входа при любом handoff (новая сессия, compression, другой агент);
- всё важное фиксируется в файлах, а не в чате;
- если контекст забит — handoff через `state.md` + файлы run-folder, без потерь;
- Claude при входе в сессию читает `state.md` → восстанавливает фазу → продолжает с нужного места.

## Handoff protocol

При каждом handoff (конец сессии, смена агента, compression):

### 1. State (всегда)

- Обновить `state.md`: phase, current step, blocker
- Run COMPLETE → `Status: complete`, убрать "in progress"

### 2. Memory (если есть cross-session value)

- Обновить статус run в memory-файле (указатель, не дубль run-файлов)
- Записать decisions/lessons, которых нет в run-файлах
- Удалить stale: завершённые планы, устаревшие TODO
- Если в сессии использовался внешний API и нашёлся gotcha → обновить SKILL.md, дату VERIFIED

### Вход в сессию

1. `MEMORY.md` → контекст, нужный run
2. `state.md` → фаза, текущий шаг
3. Skills загружаются автоматически

## Model routing

| Фаза                        | Модель        | Причина                              |
| --------------------------- | ------------- | ------------------------------------ |
| Discovery                   | Opus          | Правильные вопросы, оценка входа     |
| Research                    | Opus          | Анализ trade-offs, альтернативы      |
| Plan                        | Opus          | Архитектурные решения, scope control |
| Annotation (implementation) | **Codex CLI** | Implementation review + brief check  |
| Annotation (архитектура)    | Opus          | Red team, structural review          |
| Readiness                   | Opus          | Критическая оценка без rubber-stamp  |
| **Implement (код)**         | **Sonnet**    | Быстрый, хорош в кодировании         |
| Post-Implement Review       | **Codex CLI** | Code review перед финалом            |
| Final Review                | Opus          | Честный verdict, ловить пропущенное  |

Думающие фазы → Opus. Кодящая фаза → Sonnet. Implementation checks → Codex.

**Post-Implement Review командой:**

```bash
codex review --uncommitted
# или против main:
codex review --base main
```

Запускать перед Final Review. Результат применить или зафиксировать как "accepted / deferred".

## Output style

- коротко;
- по делу;
- без маркетинговой ваты;
- если идея слабая — говори прямо;
- если scope разъезжается — тормози и фиксируй рамку.

## Default first response in a fresh run

1. Подтверди, что работаешь в `Kurdyuk Lite`.
2. Проверь, есть ли `.kurdyuk-lite/runs/<project-slug>/`.
3. Если нет — создай run-folder из шаблонов.
4. Если discovery-опоры не заполнены — задай **первый** вопрос.
5. Не начинай research или код раньше времени.
