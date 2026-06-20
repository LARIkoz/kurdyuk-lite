# Discovery Toolkit — optional Phase 1 aids

> **Optional.** Kurdyuk Lite's pipeline is methodology-agnostic — the Charter holds _principles_,
> not a discovery method. This file is an opt-in layer for **Phase 1 (Brainstorm + Research + Brief)**
> when your product is consumer- or jobs-shaped and you want a sharper read on _who it's for_ and
> _what's risky_ before you write the Brief.
>
> `init` does **not** copy this into your project — it lives in `reference/`, like the worked charters.
> Use it by reading it during Phase 1, or paste a scaffold below into the chat.
>
> These are established product-discovery methods, named separately so you can study each at its
> source (see [Credits](#credits)). They are rewritten here in Kurdyuk's own words; no third-party
> course material is reproduced.

## What this feeds

| Method                   | Feeds which `brief.md` field  |
| ------------------------ | ----------------------------- |
| Jobs & the job hierarchy | problem / job · who           |
| Jobs-based segmentation  | who (persona)                 |
| Critical sequence        | problem · what's NOT in scope |
| Four Forces              | market context                |
| Riskiest Assumption Test | hypotheses                    |
| Laddering interview      | the whole brainstorm          |

Keep numbers and evidence in `brief.md` — **never** in the Charter. The Charter stays heuristic-free
(see [`charter-for-charter.md`](../charter-for-charter.md)).

---

## 1. Jobs-to-be-Done & the job hierarchy

People don't buy products; they _hire_ them to make progress in a situation. Describe that progress
as a **job**, and notice jobs sit at different altitudes:

- **Big Job** — the higher goal that gives the work meaning. One level above what your product can
  fully deliver. _("Confidently bring a healthy new hire on board.")_
- **Core Job** — the highest job your product completes end-to-end. This is what the customer
  actually pays for. _("Get a new hire's data into the system fast and without errors.")_
- **Small Job** — sub-jobs under the Big Job; your product may or may not do them.
- **Micro Job** — low-level steps users see as a necessary evil _("pick the right menu item")_.
  Matters for UX, useless for segmentation.

Pick the **Core Job** as your unit. Too low → the segment is a niche of a niche; too high
_("be happy")_ → nothing actionable.

**Job-statement scaffold:**

```
When  [context] + [trigger] + [what they already tried],
I want [desired outcome] — judged good by [success criteria],
so that [the higher job] and I feel [emotional shift].
```

## 2. Jobs-based segmentation

A segment is **not** a demographic. It's a group of people with a _similar bundle of jobs_, similar
**success criteria**, in a similar **context**. Demographics are at most a filter on top.

**Scaffold — propose and rank segments:**

```
You are a product strategist using Jobs-to-be-Done.
From this product idea: [idea]
1. Build 3-5 candidate segments. Each = a bundle of 1-4 Core Jobs + exactly one Big Job,
   distinguished by context, customer role, and success criteria.
2. Score each (silently) on: market size (TAM/SAM/SOM, show the rough math),
   value (how much better it closes the job bundle than today's options),
   profitability (job frequency, willingness to pay, repeat purchase),
   reachability (channels, an existing habit of paying).
3. Output only the top 3, sorted. For each: name · Core Jobs (When…/I want…) ·
   success criteria · who they are · Big Job · TAM/SAM/SOM with one-line logic ·
   why it's attractive.
Describe motivations and situations, not "pain points."
```

## 3. Critical sequence of jobs

The Big Job is reached through steps the user **cannot skip**. _("Get a telemedicine diagnosis"
= install → register → pick a doctor → pay → join the call.)_ Map the sequence, then find the step
where people **break off**. That broken step is usually where your product's value — or your biggest
risk — lives.

## 4. Four Forces (why people switch)

Adopting anything new is a switch, and four forces pull against each other (the README frames Kurdyuk
itself this way):

- **Push** — what's bad about the current way.
- **Pull** — what attracts them to the new way.
- **Habit** — inertia keeping them on the old way.
- **Anxiety** — fear about the new way.

A switch happens only when **Push + Pull > Habit + Anxiety**. In discovery, list all four for your
Core Job — your Brief's _market context_ and your product's messaging both fall out of it.

## 5. Riskiest Assumption Test (RAT)

Find the assumptions that, **if false, kill the product** — and test the cheapest, deadliest ones
first.

**Scaffold — surface and rank risks:**

```
For this product [idea + stage + segment hypotheses + business model],
list the assumptions it depends on. For the top 3, give:
- name · the assumption as a concrete, checkable statement · why it's fatal if wrong ·
  category (demand / segment economics / willingness to pay / unit economics / scaling / ops) ·
  Probability it's wrong (1-5) · Impact if wrong (1-5) · the cheapest test that would settle it.
Score = Probability x Impact; sort descending. Output 3 cards, no process narration.
```

The top cards become your Brief's **hypotheses** — and the riskiest one tells Research what to
investigate first.

## 6. Laddering interview ("go one level up")

Run the Phase-1 brainstorm as an interview, not a form:

- **One question per message.** Wait for the answer before the next.
- When the user says _"I want X,"_ ask _"why?"_ / _"so that what?"_ — climb until you hit the Big Job,
  then stop before it turns abstract _("be happy")_.
- Offer generated segments and risks back as **choices**, not a wall of text.
- Save edge-case questions for last (cap ~7).

The answers map straight onto `brief.md`: idea → definition · jobs → problem · chosen segment → who ·
chosen risks → hypotheses · explicit cuts → what's NOT in scope.

---

## Credits

These methods are not Kurdyuk's invention — study them at the source:

- **Jobs-to-be-Done**, the Big/Core Job hierarchy — Clayton Christensen; the applied **AJTBD**
  synthesis these scaffolds were distilled from: **Ivan Zamesin** ("Как делать продукт").
- **Four Forces of switching** — Bob Moesta and the JTBD "switch" school.
- **Riskiest Assumption Test** — lean / MVP practice.

Rewritten in Kurdyuk's own words. No course material is reproduced verbatim.
