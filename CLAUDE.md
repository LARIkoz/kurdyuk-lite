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

## Research phase

Research идёт в 1–2 прохода:

1. **Pass 1 (broad scan)** — параллельно 3 канала:
   - **Exa** `/research` или `/search` — structured data: конкуренты, pricing, market size, app reviews. JSON schema для structured output.
   - **Gemini CLI** background — свежие новости, PDF, визуальный контент, то что Exa не покрывает.
   - **GitHub** (`gh search repos/code/issues`) — reference implementations, open issues, community solutions, repo landscape. `--cache 1h` для экономии rate limit.
2. Opus синтезирует результаты всех каналов → фиксирует в `research.md`. Помечает пункты как `verified` или `unverified / needs deeper look`.
3. **Pass 2 (targeted, условный)** — если после Pass 1 есть `unverified` пункты, конфликтующие данные или вскрылась неожиданная область — Exa targeted search + Gemini background с конкретными вопросами по gaps. Если Pass 1 достаточен — сразу в Plan.
4. Opus финальный синтез → обновляет `research.md`.

Максимум **2 прохода**. Решение о Pass 2 принимает Opus после синтеза Pass 1, не пользователь.

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
- **Codex (implementation reviewer)** — Claude запускает как **background sub-agent** (основная сессия продолжает работать):
  ```
  Bash(
    command="codex exec 'Review plan.md as implementation expert: check feasibility, find pitfalls, compare with brief.md for scope drift. Be direct.' -s read-only -C .kurdyuk-lite/runs/<slug>/ -o /tmp/codex-plan-review.md",
    run_in_background=true
  )
  # Когда завершится → Read /tmp/codex-plan-review.md
  ```
  Когда завершится — Claude читает результат и применяет к plan.md.
- **Design Reviewer (Gemini)** — visual review скриншотов, mockups, UI-решений. Запускается когда в задаче есть UI-компонент:
  ```
  Bash(
    command="echo 'Y' | GOOGLE_GENAI_USE_GCA=true gemini -p 'Review these UI designs/screenshots. Check: visual consistency, spacing, contrast, accessibility, iOS/Android guidelines compliance. Compare with brief.md requirements. Be specific about issues.' -m gemini-2.5-pro -o text .kurdyuk-lite/runs/<slug>/ > /tmp/gemini-design-review.md 2>/dev/null",
    run_in_background=true
  )
  # Когда завершится → Read /tmp/gemini-design-review.md
  ```
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

| Фаза                          | Модель            | Запуск              | Причина                                               |
| ----------------------------- | ----------------- | ------------------- | ----------------------------------------------------- |
| Discovery                     | Opus              | inline              | Правильные вопросы, оценка входа                      |
| Research (structured data)    | **Exa API**       | inline / background | Конкуренты, market data, app reviews, structured JSON |
| Research (web/PDF/актуальное) | **Gemini CLI**    | **background Bash** | Свежие данные из интернета, PDF, 2M контекст          |
| Research (синтез/trade-offs)  | Opus              | inline              | Анализ собранного, архитектурные альтернативы         |
| Plan                          | Opus              | inline              | Архитектурные решения, scope control                  |
| Annotation (implementation)   | **Codex CLI**     | **background Bash** | Implementation review + brief check                   |
| Annotation (design review)    | **Gemini CLI**    | **background Bash** | Visual review mockups, UI consistency                 |
| Annotation (design gen)       | **Claude inline** | inline              | Ни Codex, ни Gemini не подходят для design gen        |
| Annotation (архитектура)      | Opus              | inline              | Red team, structural review                           |
| Readiness                     | Opus              | inline              | Критическая оценка без rubber-stamp                   |
| **Implement (код)**           | **Sonnet**        | inline              | Быстрый, хорош в кодировании                          |
| Post-Implement Review         | **Codex CLI**     | **background Bash** | Code review перед финалом                             |
| Visual QA                     | **Gemini CLI**    | **background Bash** | Скриншот vs mockup, pixel-level check                 |
| Content extraction (fallback) | **Exa /contents** | inline              | WebFetch 403 fallback, чистый текст страниц           |
| Batch classification          | **Qwen CLI**      | **background Bash** | 2000 RPD free, `--system-prompt`, non-thinking        |
| Consilium (code review)       | **Qwen CLI**      | **background Bash** | Быстрый, бесплатный, pattern matching                 |
| Final Review                  | Opus              | inline              | Честный verdict, ловить пропущенное                   |

Думающие фазы → Opus. Кодящая фаза → Sonnet. Implementation checks → Codex. Structured web research → Exa. Web/PDF/visual → Gemini. Classification/review → Qwen (non-thinking, `--system-prompt`). PR review → Copilot (`gh pr edit --add-reviewer @copilot`).

**⚠️ Qwen = non-thinking.** НЕ давать reasoning/architecture/trade-off задачи. Только classification, code review, pattern matching. Context ceiling 130K (не 1M). Детали — в skill `qwen-code-cli`.

**Background запуск для Gemini и Codex:** использовать `Bash(run_in_background=true)` — команда наследует permissions основной сессии. `Agent(run_in_background=true)` ненадёжен в VS Code (permissions не наследуются, bug #25520). Agent tool — только для multi-step reasoning задач. Детали запуска — в skills `gemini-cli` и `codex-cli`.

**Параллельный запуск:** Gemini (research) + Codex (review) можно запустить одновременно как два background agent в одном сообщении.

**Batch `claude -p`:** НИКОГДА напрямую из Cursor Bash. Использовать `claude-batch` (tmux isolation) или Terminal.app. Drop-in: `claude-batch -p "prompt" --model sonnet`. Batch: `claude-batch batch -f dir/ -p 10 -m sonnet`. Причина: parallel `claude -p` из Cursor вызывает auth kickout Extension (bug #24317, #37512).

**Когда вызывать Exa:**

- Структурированный поиск конкурентов, рынка, приложений → Exa `/search` (category, domain filters, date filters)
- Глубокий автономный ресёрч → Exa `/research` (async, structured JSON output через `outputSchema`)
- Извлечение контента по URL → Exa `/contents` (чистый текст, $0.001/page, кешируется)
- Поиск похожих сайтов/приложений → Exa `/findSimilar` (дал URL → получил аналоги)
- Быстрый факт-чек с источниками → Exa `/answer` (grounded answer + citations)
- WebFetch вернул 403 → Exa `/contents` как первый fallback (до Gemini)
- Kurdyuk Research phase: Exa (structured data) + Gemini (свежак/PDF) параллельно → Opus синтез

**Когда вызывать Gemini (НЕ Exa):**

- Свежие данные < 24 часов (Exa index lag)
- PDF документ для анализа или конвертации
- Контекст > 100K токенов (вся кодовая база, большой документ)
- Скриншот / схема / wireframe анализ (Exa = текст only)
- Задача требует vision (mockups, UI review)

**Post-Implement Review:** Codex как background agent, результат в `/tmp/codex-impl-review.md`. Зафиксировать в `final-review.md` как "accepted / deferred".

**Visual QA (post-implement, если есть UI):** Gemini сравнивает скриншот реализации с mockup/brief. Запускать параллельно с Codex post-implement review:

```
Bash(
  command="echo 'Y' | GOOGLE_GENAI_USE_GCA=true gemini -p 'Compare the implemented UI screenshot with the original mockup/design requirements. List: pixel differences, missing elements, spacing issues, color mismatches. Be specific.' -m gemini-2.5-pro > /tmp/gemini-visual-qa.md 2>/dev/null",
  run_in_background=true
)
# Когда завершится → Read /tmp/gemini-visual-qa.md
```

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
# Copilot test
