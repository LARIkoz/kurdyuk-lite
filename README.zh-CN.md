# Kurdyuk Lite

**一个以 Charter（章程）驱动的 AI 编程代理产品开发框架。**

别再和你的 AI 代理"闲聊"了。开始"指挥"它——通过一个严格的六阶段流水线，核心是一份书面章程。原生支持 Claude Code；同时兼容 Codex、Gemini 以及任何能读取项目指令文件的代理。

```
Brainstorm+Research+Brief → Charter → Spec → Plan → Implement → Final Review
```

[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE) [![Version](https://img.shields.io/github/v/tag/LARIkoz/kurdyuk-lite?label=version&color=blue)](CHANGELOG.md) [![PRs welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md) [![Agents: Claude · Codex · Gemini](https://img.shields.io/badge/agents-Claude%20%C2%B7%20Codex%20%C2%B7%20Gemini-8A63D2.svg)](#works-with-any-agent)

[🇬🇧 English](README.md) · [🇷🇺 Русский](README.ru.md) · [🇯🇵 日本語](README.ja.md) · **🇨🇳 中文**

_本翻译由社区维护，可能落后于[英文原文](README.md)。_

_Bash + Markdown · 零依赖 · 适用于任何代码仓库_

---

## 问题

你打开 Claude Code，带着一个真实的产品想法。三小时后，你得到的是一堆半成品功能、悄悄偏移的目标线，以及一个在你没要求的地方自作主张"改进"的代理。上下文没了。你下午两点做的决定无处可寻——既不在文件里，也不在代理被压缩（compaction）后的记忆中。你在重做 AI 已经做过的工作，因为它跑偏了。

与强大的代理自由聊天既快又诱人——但代价是：**上下文丢失、范围蔓延、无声偏移，以及决策原因毫无记录。**

## Kurdyuk Lite 做什么

它在工作流下面加了一条**轨道**。六个阶段，每个阶段产出一份工件，每次都需要你明确说"OK"才能进入下一阶段。不能跳过，不能合并，不能"我先写点代码再说"。

核心是 **Charter（章程）**——一份简短的、编号的产品章程。它不是规格说明，也不是待办列表：而是*原则*。编号顺序即优先级。每一个设计和实现决策都要对照它检查；违反章程是**阻塞项**，不是讨论话题。

代理从**文件恢复，而非聊天记忆**——因此 `/compact`、新会话或者一周的间隔都不会丢失工作进度。

---

## 本框架解决的任务

我们围绕一个 **Big Job**（用 Jobs-to-be-Done 的术语来说，即你真正雇佣它的更高目标）设计了 Kurdyuk Lite：

> **"用 AI 代理为主力，交付一个我能拿得出手的产品——同时不失去对它的控制，也不把自己搞崩溃。"**

这个任务有三个层次，框架服务于每一层：

- **功能层** — 借助代理将想法变成可运行的、连贯的软件。
- **情感层** — 感到*掌控感*，而不是焦虑代理正在悄悄跑偏。
- **社交层** — 产出你能展示给队友或用户并**有据可辩**的成果："这就是*为什么*这样构建。"

Big Job 永远不可能被一个工具完全解决。其下是 Kurdyuk Lite 实际关闭的 **Core Job**：

> **与 AI 代理一起运行一个有纪律的"想法→评审"流程，确保没有重要内容被即兴发挥或遗失。**

而**关键序列**——那些跳过任何一步整件事就会失败的步骤——*正是*这六个阶段：

| 阶段             | 该阶段解决的任务                                          |
| ---------------- | --------------------------------------------------------- |
| **Brief**        | 就构建什么、为谁构建、什么不在范围内达成一致              |
| **Charter**      | 确定原则，后续所有决策都依据这些原则来评判                |
| **Spec**         | 将原则转化为具体的、可测试的需求                          |
| **Plan**         | 将规格说明拆解为有序的、可验证的任务                      |
| **Implement**    | 逐个任务构建，证明每个任务完成——绝不伪造完成              |
| **Final Review** | 对照 Charter + Spec 验证；给出 `go / revise / no-go` 结论 |

去掉 Charter，代理就在真空中优化。去掉门禁，范围就会悄悄扩大。每个文件都有存在的理由。

### 为什么你会切换过来（四力模型）

从"直接和代理聊天"转变到"通过流水线指挥代理"是一个行为切换——切换受四种力量支配：

- **推力（Push）** — 今天让你痛苦的：上下文蒸发、代理偏离任务、范围蔓延、决策原因无记录。每一个都是你没计划过的额外工作。
- **拉力（Pull）** — 吸引你过来的：跨阶段和压缩后依然存活的上下文、钉在 Charter 中可以指向的决策、违反原则的那一刻就能被捕获的偏移。
- **惯性（Habit）** — 让你留在聊天模式的：立刻开始写代码的反射动作、"我问代理就行"的肌肉记忆、以为自己什么都记得住的信念。
- **焦虑（Anxiety）** — 让你犹豫的：_这会不会拖慢我？Charter 会不会变成官僚流程？代理真的能遵循流程吗？_

Kurdyuk Lite 刻意做到**轻量（Lite）**来克服后两种力：一个上下文、八个 Markdown 模板、只需几秒的门禁检查。纪律是真的；负担不是。

> **坦诚说明。** 这是我们基于 Jobs-to-be-Done（AJTBD 学派）语言构建的*设计假说*——**不是**经过验证的用户研究。如果你使用它，你的现实才是真正的检验。

---

## 一次运行是什么样的

1. **Brief** — 你和代理一起头脑风暴；它收敛为 `brief.md`（一行定义、面向谁、什么*不*在范围内），然后等你说"brief OK"。
2. **Charter** — 它将编号原则综合到 `charter.md` 中。在一行规格说明存在之前，你就审视了产品的灵魂。
3. **Spec** — 原则变成功能/非功能需求，附带验收标准，每条追溯到一项原则。
4. **Plan** — 规格说明变成有序的任务，在 `plan.md` / `todo.md` 中带有"完成条件"。
5. **Implement** — 代理逐个任务执行，证明每个任务已完成。如果某个选择违反了 Charter，它会停下来并标记。
6. **Final Review** — 对照每项原则和每条验收标准给出结论。

每个阶段都会更新 `state.md`（项目的真实状态）并追加到 `gate-log.md`（审批记录）。随时通过读取这两个文件来恢复工作。

## 关于 Charter

Charter 是一份章程，在四条规则下编写（见 [`charter-for-charter.md`](charter-for-charter.md)）：**不用经验法则、不写 HOW、每条原则都是一个测试、先写后删。** 编号排列、按优先级排序、每条不超过三句话。以下是来自完整示例 [`reference/example-charter.md`](reference/example-charter.md) 的片段：

```
1. The app exists to make money. Persuasion is business; deception is debt.
2. One tap to focus. Starting a session must never require setup.
3. The timer is sacred. A running session is never interrupted by upsells.
4. Honest time. Reported focus time reflects real elapsed focus only.
5. Works offline. Core timing functions with no network.

When principles conflict, lower number wins.
```

现在"我们是否应该在启动页面前加付费墙？"有了答案——_违反 P2_——不需要开会讨论。

## 安装

### 一行命令——让代理来安装

将以下内容粘贴到你项目中打开的任何 AI 编程代理（Claude Code、Codex、Gemini CLI 等）中：

> **Install Kurdyuk Lite in this repo: follow `https://raw.githubusercontent.com/LARIkoz/kurdyuk-lite/main/BOOTSTRAP.md` — pick the `--agent` that matches you, then run `check` and report the Status line.**

代理会克隆框架、将合约注入其*自身*的指令文件（`CLAUDE.md` / `AGENTS.md` / `GEMINI.md`）、验证安装并报告健康状态——零手动操作，适用于任何代理。它遵循的操作手册是 [`BOOTSTRAP.md`](BOOTSTRAP.md)。

### 手动安装

```bash
git clone https://github.com/LARIkoz/kurdyuk-lite.git ~/.kurdyuk-lite
~/.kurdyuk-lite/bin/kurdyuk-lite init .      # injects the contract into ./CLAUDE.md + copies templates
~/.kurdyuk-lite/bin/kurdyuk-lite check .     # → Status: UP TO DATE
```

或者用一条命令完成克隆 + 初始化 + 验证，同时选择写入哪个代理文件：

```bash
curl -fsSL https://raw.githubusercontent.com/LARIkoz/kurdyuk-lite/main/bin/kurdyuk-install | bash -s -- --agent claude .
```

`init` 是幂等且无破坏的：它向你项目的指令文件中注入一个标记块（会先备份已有文件），将模板放入 `.kurdyuk-lite/`，并更新 `.gitignore`。再次运行即可升级。

## 适用于任何代理

合约是纯 Markdown——任何能加载项目指令文件的编程代理都能运行它。`init` 会为你选择的代理写入对应文件：

```bash
kurdyuk-lite init .                 # Claude Code  → CLAUDE.md   (default)
kurdyuk-lite init . --agent codex   # Codex / others → AGENTS.md
kurdyuk-lite init . --agent gemini  # Gemini CLI   → GEMINI.md
kurdyuk-lite init . --agent all     # all three at once
```

`AGENTS.md` 是跨工具标准，因此 `--agent codex` 也涵盖其他支持 AGENTS.md 的代理。使用其他工具（Cursor、Aider 等）？将其指向 `CLAUDE-contract.md`，或者将注入的块复制到该工具自己的指令文件中。`check` 无论合约存在于哪个文件中都一样工作。

## 快速开始

在你的仓库中打开 Claude，粘贴 `.kurdyuk-lite/STARTER-PROMPT.md` 或者直接说出你想构建什么。代理会确认进入 Kurdyuk Lite 模式，创建运行文件夹，并开始第一阶段。

## 何时使用

- **3-7 个任务，1-2 个会话** → Kurdyuk Lite 的最佳适用场景。
- **8 个以上任务、多会话、需要设计验证门禁** → 你已经超出了 Lite 的范围；拆分工作或使用更重量级的流程。
- **一行修复或快速重构** → 不需要框架。别把章程搬来改个错别字。

## 包含什么

```
kurdyuk-lite/
├── CLAUDE.md              # thin wrapper → points at the contract
├── CLAUDE-contract.md     # the canonical operating contract (injected into your project)
├── concept.md             # full methodology + charter deep dive
├── charter-for-charter.md # the 4 rules for writing a charter
├── BOOTSTRAP.md           # one-paste installer · MIGRATION.md — upgrade notes
├── bin/                   # kurdyuk-lite (init/check) · kurdyuk-install (bootstrap)
├── reference/             # worked charter examples + optional discovery toolkit (not copied into your project)
└── templates/             # the 8 phase templates init copies into .kurdyuk-lite/templates/
```

## 环境要求

一个能读取项目指令文件的 AI 编程代理——[Claude Code](https://claude.com/claude-code)（默认）、Codex、Gemini CLI 或类似工具。除此之外不需要任何东西：Kurdyuk Lite 只是 Bash + Markdown。

## 致谢

Kurdyuk Lite 由已有的成熟方法论组装而成——分别列出以便你查阅各来源：

- **Jobs-to-be-Done**（Clayton Christensen）— 本 README 所用的 Big/Core Job 框架。可选的第一阶段脚手架背后的应用 **AJTBD** 综合方法论：**Ivan Zamesin**。
- **切换四力模型（Four Forces of switching）**（Push / Pull / Habit / Anxiety）— Bob Moesta 与 JTBD "切换"学派。
- **最高风险假设测试（Riskiest Assumption Test）** — 精益 / MVP 实践。
- **标注循环（Annotation cycle）** — 分轮次评审计划的循环（以及若干 Claude Code 工作模式）来自 **Boris Tane**，["How I use Claude Code"](https://boristane.com/blog/how-i-use-claude-code/)。

从 JTBD 方法论中提炼的可选第一阶段发现脚手架位于 [`reference/discovery-toolkit.md`](reference/discovery-toolkit.md)——用我们自己的语言重写，选择性使用，绝不复制到你的项目中。

## 常见问题

**Kurdyuk Lite 是什么？**
一个以 Charter 驱动的 Claude Code 产品开发框架。它引导你的 AI 编程代理经过六个有门禁的阶段——Brief → Charter → Spec → Plan → Implement → Final Review——以编号的"Charter"（产品章程）为核心。

**它和直接使用 Claude Code 有什么不同？**
纯聊天是开放式的：代理可能跳过步骤、跑偏、遗忘。Kurdyuk Lite 增加了门禁（每个阶段需要你的"OK"）、Charter（每个决策都对照书面原则检查）和基于文件的状态（工作在 `/compact` 或新会话后依然存在）。

**它能和 Cursor、Codex、Gemini 或其他 AI 代理一起用吗？**
可以。合约是纯 Markdown。`init --agent codex` 写入 `AGENTS.md`，`--agent gemini` 写入 `GEMINI.md`，`--agent all` 写入所有文件。其他工具可以直接指向 `CLAUDE-contract.md`。Claude Code 是默认且测试最充分的目标。

**这个流程会不会拖慢我？**
门禁只需几秒；Charter 只有几行。它节省的时间——不必重做代理偏离后产生的工作——才是重点。一行修复就直接做，不需要它。

**能加到已有项目中吗？**
可以。`init` 是无破坏性的：它向已有的 `CLAUDE.md` 注入一个标记块（先备份），并添加 `.kurdyuk-lite/` 文件夹。随时重新运行即可升级。

**我的代码或数据会被发送到任何地方吗？**
不会。Kurdyuk Lite 是 Bash + Markdown，没有网络请求，没有遥测。它只在你的仓库中写入文件；其他一切都在你自己的 Claude Code 会话中进行。

**用一句话说，Charter 是什么？**
一份简短的、编号的产品章程——编号顺序即优先级——将"我们该不该做 X？"变成可检验的答案（"违反 P2"），而不是一场讨论。

## 参与贡献

欢迎提交 Issue 和 PR——请参阅 [CONTRIBUTING.md](CONTRIBUTING.md)、[行为准则](CODE_OF_CONDUCT.md) 和[安全政策](SECURITY.md)。版本历史见 [CHANGELOG.md](CHANGELOG.md)。

## 许可证

MIT——见 [LICENSE](LICENSE)。随意使用、fork、随项目发布。
