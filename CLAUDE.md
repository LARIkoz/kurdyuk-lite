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
6. Не переводи работу в финальный review, пока все обязательные задачи в `todo.md` не закрыты.
7. Если по пути всплыл material change — обнови `brief.md`, `intent.md`, `invariants.md`, `research.md` или `plan.md` явно. Не делай тихую подмену смысла.
8. Держи процесс коротким. Не плодить decorative docs.
9. **Phase gate:** после завершения каждой фазы покажи результат и дождись подтверждения пользователя перед переходом к следующей. Не перескакивай фазы молча. Порядок gates: Discovery ✓ → Research ✓ → Plan ✓ → Readiness ✓ → Implement ✓ → Final Review.

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

После создания `plan.md` пользователь может открыть его в редакторе и добавить inline-аннотации прямо в документ:
- коррекция подхода: "no — this should be PATCH, not PUT"
- удаление лишнего: "remove this section entirely"
- доменные знания: "use drizzle:generate for migrations, not raw SQL"
- переструктурирование: "visibility field должен быть на list, не на item"

Правила:
- 1–6 итераций аннотаций — нормально;
- Claude читает аннотации, обновляет plan.md, показывает diff;
- пока пользователь не сказал "plan OK" — implement запрещён;
- аннотации — основной способ передать доменные знания и скорректировать архитектуру до написания кода.

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

При каждом handoff (конец сессии, смена агента, compression, переключение контекста) **обязательно обновить ВСЕ ТРИ слоя RAG**:

### Слой 1 — Run files (state.md + run-folder)
- Обновить phase, current step, blocker в `state.md`
- Это делается **ВСЕГДА**, даже при micro-handoff
- Run-файлы = полный контекст конкретного run

### Слой 2 — Memory (`.claude/.../memory/`)
- Обновить статус run в memory-файле (slug → phase → что осталось)
- Записать decisions/lessons, которых нет в run-файлах
- Обновить `MEMORY.md` index если появились новые файлы
- **НЕ дублировать** содержимое run-файлов — только указатели + meta

### Слой 3 — Skills (`~/.claude/skills/`)
- Если в сессии использовался внешний API/scraper/parser/npm-пакет:
  - Скилл есть → дописать gotchas/workarounds в SKILL.md
  - Скилла нет → создать `~/.claude/skills/<name>/SKILL.md` (fetch docs → verify → write)
  - Обновить `VERIFIED` дату
- Скиллы — кросс-проектные, обновлять из любого проекта

### Порядок при входе в сессию
1. `MEMORY.md` → понять контекст, найти нужный run
2. `state.md` → восстановить фазу и текущий шаг
3. Skills загружаются автоматически через `~/.claude/skills/`

### Слой 4 — Cleanup (после Update)
Завершённый артефакт опаснее отсутствующего. Stale plan = Claude думает работа не сделана.
- **Plans** (`.claude/plans/`) — реализованный план → **удалить файл**. Plan = живой контракт, не архив
- **state.md** — run COMPLETE → `Status: complete`, убрать "current step" / "in progress"
- **Memory** — пройтись по "Next Steps" / "Remaining" / "TODO". Сделано → убрать или пометить DONE
- **MEMORY.md** — убедиться что lessons/status не противоречат текущему состоянию кода

### Правила
- **Не надейся на контекст чата** — он будет потерян;
- **Не дублируй** run-файлы в memory — только указатели;
- Фиксируй то, что живёт **между** run-файлами и чатом: решения, preferences, lessons;
- Skills write-back: нашёл gotcha/workaround → допиши в скилл сразу, не откладывай;
- **Cleanup при каждом handoff** — удалять завершённые планы, обновлять stale статусы.

## Model routing

| Фаза | Модель | Причина |
|---|---|---|
| Discovery | Opus | Правильные вопросы, оценка входа |
| Research | Opus | Анализ trade-offs, альтернативы |
| Plan | Opus | Архитектурные решения, scope control |
| Readiness | Opus | Критическая оценка без rubber-stamp |
| **Implement (код)** | **Sonnet** | Быстрый, хорош в кодировании |
| Final Review | Opus | Честный verdict, ловить пропущенное |

Думающие фазы → Opus. Кодящая фаза → Sonnet.

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