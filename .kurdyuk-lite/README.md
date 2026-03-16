# Claude-native Kurdyuk Lite

Практический starter pack для **Claude-first** режима.

Не full orchestration. Не multi-agent circus. Просто рабочий Lite-процесс, который можно быстро воткнуть в любой репо.

## Для чего

Подходит, когда нужно:
- быстро прогнать идею / фичу / внутренний tool через нормальный thinking flow;
- не потерять контекст в длинном чате;
- заставить Claude сначала думать, потом планировать, потом кодить.

Не подходит, когда тебе нужен:
- full Kurdyuk с heavy review-циклами;
- отдельный Cursor adapter;
- сложная multi-agent orchestration.

## Рекомендуемая структура в целевом репо

```text
<your-repo>/
├── CLAUDE.md
└── .kurdyuk-lite/
    ├── README.md
    ├── STARTER-PROMPT.md
    ├── templates/
    │   ├── state.md
    │   ├── brief.md
    │   ├── intent.md
    │   ├── invariants.md
    │   ├── research.md
    │   ├── plan.md
    │   ├── todo.md
    │   ├── implementation-readiness.md
    │   └── final-review.md
    └── runs/
        └── <project-slug>/
```

## Установка за 3 минуты

1. Скопируй `CLAUDE.md` в корень целевого репо.
2. Скопируй содержимое этой папки в `<your-repo>/.kurdyuk-lite/`.
3. Открой Claude в контексте этого репо.
4. Вставь `STARTER-PROMPT.md`.
5. Дай идею / задачу.

## Минимальный flow

1. **Discovery floor** — 1–3 вопроса max, пока не ясны 4 опоры.
2. **Research** — 1 рекомендованный путь + 1 альтернатива.
3. **Plan** — нормальный implementation contract в `plan.md`.
4. **Readiness** — перед кодом честный `pass | revise | fail`.
5. **Implement** — выполнение через `todo.md`.
6. **Final review** — финальный вердикт `go | revise | no-go`.

## Жёсткие правила

- Сначала `state.md`, потом всё остальное.
- Не кодить до `implementation-readiness.md = pass`.
- `plan.md` = contract. `todo.md` = execution surface.
- Не менять scope молча.
- Если discovery слабый — не притворяться, что research всё починит.
- Если в процессе всплывает material change — вернуться в `brief.md / intent.md / invariants.md / plan.md`, а не тащить грязь дальше.

## Что считается first dogfood-ready state

Считай pack готовым к первому честному dogfood, если:
- Claude умеет поднять `.kurdyuk-lite/runs/<slug>/` из шаблонов без ручной возни;
- после одной сырой идеи он проходит discovery без каши;
- пишет `research.md` с **recommended path + alternative**;
- собирает `plan.md` и `todo.md` без silent scope drift;
- честно ставит `implementation-readiness.md` в `revise`, если план сырой;
- остаётся в `implement`, пока `todo.md` не закрыт;
- завершает работу через `final-review.md`, а не через чатовую болтовню.

Если хотя бы 2 пункта выше ломаются — pack ещё сырой.