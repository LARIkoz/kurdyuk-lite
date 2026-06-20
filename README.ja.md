# Kurdyuk Lite

**AIコーディングエージェントのための、Charter駆動プロダクト開発フレームワーク。**

AIエージェントと*おしゃべり*するのはやめよう。書かれた憲法を核に据えた、厳密な6フェーズのパイプラインでエージェントを*指揮*しよう。Claude Codeネイティブ対応。プロジェクト指示ファイルを読むエージェントなら、Codex、Gemini、その他なんでも動く。

```
Brainstorm+Research+Brief → Charter → Spec → Plan → Implement → Final Review
```

[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE) [![Version](https://img.shields.io/github/v/tag/LARIkoz/kurdyuk-lite?label=version&color=blue)](CHANGELOG.md) [![PRs welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md) [![Agents: Claude · Codex · Gemini](https://img.shields.io/badge/agents-Claude%20%C2%B7%20Codex%20%C2%B7%20Gemini-8A63D2.svg)](#works-with-any-agent)

[🇬🇧 English](README.md) · [🇷🇺 Русский](README.ru.md) · **🇯🇵 日本語** · [🇨🇳 中文](README.zh-CN.md)

_この翻訳はコミュニティによるもので、[英語の原文](README.md)より遅れることがあります。_

_Bash + Markdown・依存ゼロ・どのリポジトリでも動作_

---

## 問題

Claude Codeを開いて、本気のプロダクトアイデアに取りかかる。3時間後、手元には中途半端な機能の山、いつの間にかズレたゴール、頼んでもいない「改善」をやらかすエージェントが残っている。コンテキストは消えた。午後2時に下した判断はどこにも残っていない――ファイルにも、`/compact`後のエージェントの記憶にも。AIがすでにやった作業をやり直すはめになる。ドリフトしたから。

有能なエージェントとの自由なチャットは速くて中毒性がある――そしてあなたにツケを回す: **コンテキストの消失、スコープクリープ、静かなドリフト、なぜその判断をしたのかの記録がゼロ。**

## Kurdyuk Liteがやること

作業に**レール**を敷く。6つのフェーズがあり、各フェーズは1つの成果物を生成し、あなたが明示的に「OK」を出すまで次に進まない。スキップ不可。統合不可。「とりあえずコード書き始めます」は許されない。

中心にあるのが**Charter（憲章）**――プロダクトのための短い、番号付きの憲法。スペックでもバックログでもない。*原則*だ。順番＝優先度。すべての設計判断・実装判断はCharter（憲章）に照らしてチェックされ、違反は議論ではなく**ブロッカー**になる。

エージェントはチャット履歴ではなく**ファイルから再開**する。だから`/compact`しても、新しいセッションを始めても、1週間空いても、作業の流れは途切れない。

---

## このフレームワークが解決するジョブ

Kurdyuk Liteは1つの**Big Job**（Jobs-to-be-Doneの意味で――あなたがこのツールに本当に求めている上位の目標）を軸に設計された:

> **「AIエージェントで大部分を作りつつ、自分が胸を張れるプロダクトを出荷する――コントロールを失わず、燃え尽きずに。」**

このジョブには3つのレイヤーがあり、フレームワークはその全てに応える:

- **機能的** ― アイデアをエージェントと共に、一貫した動くソフトウェアに変える。
- **感情的** ― エージェントが静かに迷走しているのではないかという不安の代わりに、*コントロールしている*と感じる。
- **社会的** ― チームメイトやユーザーに見せて**弁護できる**成果物を生む:「なぜこう作ったのか、ここに理由がある。」

Big Jobは1つのツールで完結するものではない。その下にあるKurdyuk Liteが実際に解決する**Core Job**がこれだ:

> **AIエージェントとの規律ある「アイデア→レビュー」プロセスを回し、重要なことを即興や紛失にしない。**

そして**クリティカルシーケンス**――1つでも飛ばすと全体が崩壊するステップ――がまさにこの6フェーズだ:

| フェーズ         | 各フェーズが解決するジョブ                                        |
| ---------------- | ----------------------------------------------------------------- |
| **Brief**        | 何を作るか、誰のためか、スコープ外は何かを合意する                |
| **Charter**      | 以降のすべての判断が照らされる原則を決定する                      |
| **Spec**         | 原則を具体的でテスト可能な要件に変換する                          |
| **Plan**         | Spec（仕様）を順序付きの検証可能なタスクに分解する                |
| **Implement**    | タスクごとに構築し、完了を証明する――完了の偽装は許さない          |
| **Final Review** | Charter + Specに照らして検証し、`go / revise / no-go`の判定を下す |

Charter（憲章）を省けばエージェントは真空の中で最適化する。ゲートを省けばスコープが歩き出す。各ファイルには存在理由がある。

### 切り替える理由（4つの力）

*「エージェントとチャットするだけ」*から*「パイプラインでエージェントを指揮する」*への移行は行動の切り替えであり、切り替えには4つの力が働く:

- **Push（背中を押す力）** ― 今日痛いこと: コンテキストが蒸発する、エージェントがタスクから逸れる、スコープがクリープする、*なぜ*の記録がない。すべてが計画外の余計な作業。
- **Pull（引っ張る力）** ― 向こう側の魅力: フェーズ間やコンパクション後もコンテキストが生き残る、判断がCharter（憲章）にピン留めされ指差し確認できる、選択が原則に違反した瞬間にドリフトを検知。
- **Habit（習慣の力）** ― チャットに留まらせるもの: すぐにコーディングを始める反射、「エージェントに聞けばいい」という筋肉記憶、全部覚えているという思い込み。
- **Anxiety（不安の力）** ― 踏み出しを躊躇させるもの: _遅くならない？ Charter（憲章）が官僚主義にならない？ エージェントにプロセスが守れるの？_

Kurdyuk Liteが意図的に**Lite**なのは、後者2つに打ち勝つためだ: コンテキスト1つ、Markdownテンプレート8つ、数秒で終わるゲート。規律は本物。オーバーヘッドは違う。

> **正直に。** これは私たちが設計時に据えた*設計仮説*であり、Jobs-to-be-Done（AJTBDスクール）の言語で表現したもの――検証済みのユーザーリサーチでは**ない**。使ってみたあなたの現実が本当のテストだ。

---

## 実行の流れ

1. **Brief** ― エージェントとブレインストーミングし、`brief.md`（ワンライン定義、誰のためか、スコープ*外*は何か）に収束させ、あなたの「brief OK」を待つ。
2. **Charter** ― エージェントが番号付き原則を`charter.md`に合成する。仕様の1行も書かれる前に、プロダクトの魂をレビューする。
3. **Spec** ― 原則が受入基準付きの機能要件・非機能要件になり、各要件は原則にトレースバックされる。
4. **Plan** ― Spec（仕様）が「完了条件」付きの順序タスクに変換され、`plan.md` / `todo.md`に記録される。
5. **Implement** ― エージェントがタスクを1つずつ実行し、各タスクの完了を証明する。Charter（憲章）に違反する選択が生じたら、止まって報告する。
6. **Final Review** ― すべての原則とすべての受入基準に対する判定を下す。

すべてのフェーズが`state.md`（プロジェクトの真実）を更新し、`gate-log.md`（承認の記録）に追記する。この2ファイルを読めばいつでも再開できる。

## Charter（憲章）、具体的には

Charter（憲章）は憲法であり、4つのルール（[`charter-for-charter.md`](charter-for-charter.md)を参照）の下で書かれる: **ヒューリスティック禁止、HOW禁止、すべての原則はテスト可能、書いてから削る。** 番号付き、優先度順、各3文以内。実例チャーター[`reference/example-charter.md`](reference/example-charter.md)から一部:

```
1. The app exists to make money. Persuasion is business; deception is debt.
2. One tap to focus. Starting a session must never require setup.
3. The timer is sacred. A running session is never interrupted by upsells.
4. Honest time. Reported focus time reflects real elapsed focus only.
5. Works offline. Core timing functions with no network.

When principles conflict, lower number wins.
```

「スタート画面をペイウォールでゲートすべきか？」に対して、会議ではなく答えが出る――_P2に違反_。

## インストール

### ワンライン ― エージェントにインストールさせる

あなたのプロジェクトで開いているAIコーディングエージェント（Claude Code、Codex、Gemini CLIなど）に以下を貼り付ける:

> **Install Kurdyuk Lite in this repo: follow `https://raw.githubusercontent.com/LARIkoz/kurdyuk-lite/main/BOOTSTRAP.md` — pick the `--agent` that matches you, then run `check` and report the Status line.**

エージェントがフレームワークをクローンし、自身の指示ファイル（`CLAUDE.md` / `AGENTS.md` / `GEMINI.md`）にコントラクトを注入し、インストールを検証して健全性の判定を報告する――手作業ゼロ、どのエージェントでも可能。エージェントが従うランブックは[`BOOTSTRAP.md`](BOOTSTRAP.md)。

### 手動インストール

```bash
git clone https://github.com/LARIkoz/kurdyuk-lite.git ~/.kurdyuk-lite
~/.kurdyuk-lite/bin/kurdyuk-lite init .      # injects the contract into ./CLAUDE.md + copies templates
~/.kurdyuk-lite/bin/kurdyuk-lite check .     # → Status: UP TO DATE
```

または、書き込むエージェントファイルを選びつつ、クローン + init + 検証を1コマンドで:

```bash
curl -fsSL https://raw.githubusercontent.com/LARIkoz/kurdyuk-lite/main/bin/kurdyuk-install | bash -s -- --agent claude .
```

`init`は冪等かつ非破壊: プロジェクトの指示ファイルにマーク付きブロックを注入し（既存ファイルがあればバックアップ）、テンプレートを`.kurdyuk-lite/`に配置し、`.gitignore`を更新する。アップグレード時は再実行するだけでよい。

## あらゆるエージェントに対応

コントラクトはプレーンなMarkdownだ。プロジェクト指示ファイルを読み込むコーディングエージェントなら何でも実行できる。`init`は選択したエージェント用にファイルを書き出す:

```bash
kurdyuk-lite init .                 # Claude Code  → CLAUDE.md   (default)
kurdyuk-lite init . --agent codex   # Codex / others → AGENTS.md
kurdyuk-lite init . --agent gemini  # Gemini CLI   → GEMINI.md
kurdyuk-lite init . --agent all     # all three at once
```

`AGENTS.md`はクロスツール標準のため、`--agent codex`は他のAGENTS.md対応エージェントもカバーする。別のツール（Cursor、Aiderなど）を使っている場合は、`CLAUDE-contract.md`を参照させるか、注入済みブロックをそのツール独自の指示ファイルにコピーする。`check`はどのファイルにコントラクトがあっても同じように動作する。

## クイックスタート

リポジトリでClaudeを開き、`.kurdyuk-lite/STARTER-PROMPT.md`を貼り付けるか、作りたいものを伝えるだけ。エージェントがKurdyuk Liteモードを確認し、実行フォルダを作成し、Phase 1を開始する。

## いつ使うか

- **タスク3〜7個、セッション1〜2回** → Kurdyuk Liteのスイートスポット。
- **タスク8個以上、マルチセッション、設計バリデーションゲートあり** → Liteの守備範囲を超えている。作業を分割するか、より本格的なプロセスを使う。
- **ワンラインの修正やクイックリファクタ** → フレームワーク不要。タイポに憲法は持ち出さない。

## 同梱内容

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

## 要件

プロジェクト指示ファイルを読み込むAIコーディングエージェント ― [Claude Code](https://claude.com/claude-code)（デフォルト）、Codex、Gemini CLI、または同等のもの。それ以外は不要: Kurdyuk LiteはBash + Markdownだけで動く。

## 謝辞

Kurdyuk Liteは確立された手法を組み合わせたものだ。各ソースにたどれるよう、個別に名前を挙げる:

- **Jobs-to-be-Done**（Clayton Christensen） ― このREADMEが基盤とするBig/Core Jobフレーミング。オプションのPhase-1スキャフォールドの背景にある応用**AJTBD**合成: **Ivan Zamesin**。
- **切り替えの4つの力**（Push / Pull / Habit / Anxiety） ― Bob MoestaとJTBD「スイッチ」学派。
- **Riskiest Assumption Test** ― リーン/MVPの実践手法。
- **アノテーションサイクル** ― プランをパスでレビューするループ（およびいくつかのClaude Codeワークパターン）は**Boris Tane**の["How I use Claude Code"](https://boristane.com/blog/how-i-use-claude-code/)に由来。

JTBD手法から蒸留されたオプションのPhase-1ディスカバリースキャフォールドは[`reference/discovery-toolkit.md`](reference/discovery-toolkit.md)にある。独自の言葉で書き直され、オプトイン方式で、あなたのプロジェクトにはコピーされない。

## FAQ

**Kurdyuk Liteとは何ですか？**
Claude Codeのための、Charter（憲章）駆動プロダクト開発フレームワークです。AIコーディングエージェントを、ゲート付きの6フェーズ ― Brief → Charter → Spec → Plan → Implement → Final Review ― で実行し、番号付きの「Charter（憲章）」（プロダクトの憲法）を中心に据えます。

**普通にClaude Codeを使うのと何が違いますか？**
素のチャットはオープンエンドで、エージェントが先に飛んだり、ドリフトしたり、忘れたりする余地があります。Kurdyuk Liteはゲート（各フェーズにあなたの「OK」が必要）、Charter（憲章）（すべての判断が書かれた原則に照らされる）、ファイルベースの状態（`/compact`や新セッションでも作業が残る）を追加します。

**Cursor、Codex、Gemini、その他のAIエージェントでも動きますか？**
はい。コントラクトはプレーンなMarkdownです。`init --agent codex`は`AGENTS.md`を書き出し、`--agent gemini`は`GEMINI.md`を書き出し、`--agent all`ですべてのファイルを生成します。その他のツールでは、`CLAUDE-contract.md`をエージェントに参照させてください。Claude Codeがデフォルトであり、最もテストされたターゲットです。

**プロセスのせいで遅くなりませんか？**
ゲートは数秒、Charter（憲章）は数行です。エージェントがドリフトした作業をやり直さずに済む時間こそが効果です。ワンラインの修正なら省略してください。

**既存のプロジェクトに追加できますか？**
はい。`init`は非破壊です。既存の`CLAUDE.md`にマーク付きブロックを注入し（まずバックアップを取り）、`.kurdyuk-lite/`フォルダを追加します。アップグレード時はいつでも再実行できます。

**コードやデータはどこかに送信されますか？**
いいえ。Kurdyuk LiteはBash + Markdownで、ネットワーク通信もテレメトリもありません。書き込むのはリポジトリ内のファイルだけで、それ以外はすべてあなた自身のClaude Codeセッション内で完結します。

**Charter（憲章）を一言で言うと？**
プロダクトのための短い番号付き憲法 ― 順番＝優先度 ― で、「Xをすべきか？」を議論ではなくチェック可能な答え（「P2に違反」）に変えるものです。

## コントリビューション

IssueとPRを歓迎します ― [CONTRIBUTING.md](CONTRIBUTING.md)、[行動規範](CODE_OF_CONDUCT.md)、[セキュリティポリシー](SECURITY.md)をご覧ください。バージョン履歴は[CHANGELOG.md](CHANGELOG.md)にあります。

## ライセンス

MIT ― [LICENSE](LICENSE)を参照。使う、フォークする、同梱する。自由にどうぞ。
