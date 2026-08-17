# 用語早見表の確認ソース

到達できないホストを「一次で取れた」と書かない。01_ai-news-Master の 2026-08 時点の記録を初期値にする。回復したらこのファイルの取得方法を直す。

凡例:

- **WebFetch**: HTML を直接取る
- **WebSearch**: 検索。ヒットだけでは `index.html` を変えない（`fetch-flow.md`）

---

## OpenAI / ChatGPT

### developers.openai.com changelog
- URL: https://developers.openai.com/changelog
- 検索キーワード: `OpenAI platform changelog 2026`
- 取得方法: WebFetch → 失敗時 WebSearch
- 注目点: モデル追加・廃止、API・料金（開発者向け。コンシューマ名の手がかり）
- 備考: `platform.openai.com` はオリジン403が続きやすい。こちらを先に試す

### community.openai.com announcements
- URL: https://community.openai.com/c/announcements/6
- 検索キーワード: `OpenAI announcements ChatGPT 2026`
- 取得方法: WebFetch → 失敗時 WebSearch
- 注目点: モデル名、ChatGPT 機能の公式告知

### openai.com / help.openai.com / learn.chatgpt.com
- URL: https://openai.com/news
- URL: https://help.openai.com/en/articles/6825453-chatgpt-release-notes
- URL: https://openai.com/chatgpt/pricing
- URL: https://learn.chatgpt.com/docs/changelog
- 検索キーワード: `ChatGPT release notes 2026` / `ChatGPT pricing 2026` / `site:learn.chatgpt.com changelog 2026`
- 取得方法: **WebSearch を先に**。01 ではオリジン403またはゲートウェイ拒否
- 注目点: プラン料金、機能改名、提供終了（Sora 等）
- 備考: WebFetch が通ったら一次に昇格してよい。通るまでは「届いた」と書かない

---

## Anthropic / Claude

### Claude Release Notes
- URL: https://support.claude.com/en/articles/12138966-release-notes
- 検索キーワード: `Claude release notes 2026`
- 取得方法: WebFetch → 失敗時 WebSearch
- 注目点: アプリ機能名、改名、プラン変更
- 備考: 01 は 2026-08-04 以降 WebFetch 復旧を記録

### claude.com 製品・料金
- URL: https://claude.com
- URL: https://claude.com/pricing
- 検索キーワード: `Claude pricing Pro Max 2026`
- 取得方法: WebFetch → 失敗時 WebSearch
- 注目点: Pro / Max の表示価格、機能名（Artifacts、Research、Claude Design 等）

### platform.claude.com モデル
- URL: https://platform.claude.com/docs/en/about-claude/models/overview
- 検索キーワード: `Claude models Fable Opus Sonnet Haiku 2026`
- 取得方法: WebFetch → 失敗時 WebSearch
- 注目点: モデル世代名（§03）

### anthropic.com/news
- URL: https://www.anthropic.com/news
- 検索キーワード: `Anthropic news announcement 2026`
- 取得方法: WebSearch（オリジン403になりやすい）
- 注目点: 大型発表。検索ヒットだけでは表を変えない

---

## Google / Gemini

### Gemini アプリ・ヘルプ
- URL: https://gemini.google.com
- URL: https://support.google.com/gemini
- 検索キーワード: `Gemini app features rename 2026` / `Google AI Pro Ultra pricing 2026`
- 取得方法: WebFetch を試し、失敗なら WebSearch
- 注目点: 機能名（Gems、Canvas、Deep Research、Gemini Notebook）、プラン名と料金
- 備考: `support.google.com` / `gemini.google` / `blog.google` は 01 でゲートウェイ拒否が出ている

### Workspace / 企業向け改名
- URL: https://workspaceupdates.googleblog.com
- 検索キーワード: `NotebookLM Gemini Notebook 2026` / `Vertex AI Gemini Enterprise 2026`
- 取得方法: WebSearch（ゲートウェイ拒否時）
- 注目点: §05 の改名（NotebookLM、Vertex AI 等）

---

## Microsoft / Copilot

### learn.microsoft.com
- URL: https://learn.microsoft.com/en-us/copilot
- URL: https://learn.microsoft.com/en-us/microsoft-365-copilot
- 検索キーワード: `Microsoft 365 Premium Copilot Pro 2026` / `Microsoft 365 Copilot pricing 2026`
- 取得方法: WebFetch → 失敗時 WebSearch
- 注目点: Copilot 機能名、Copilot Pro 終了、Microsoft 365 Premium、ビジネス料金
- 備考: 01 ではセッションによって `learn.microsoft.com` が拒否される。失敗時は未確定

### サポート・料金
- URL: https://www.microsoft.com/en-us/microsoft-365/buy/compare-all-microsoft-365-products
- URL: https://support.microsoft.com
- 検索キーワード: `Microsoft 365 Premium price 2026` / `Copilot Pro end of support`
- 取得方法: WebFetch → 失敗時 WebSearch

---

## 日本・EU（§07）

検索だけでは表を変えない。官公庁または EUR-Lex の本文が取れたときだけ日付・版を直す。

- 総務省・経産省 AI事業者ガイドライン: 検索 `AI事業者ガイドライン 第1.2版`
- 文化庁「AIと著作権に関する考え方について」
- 内閣府 / デジタル庁 AI推進法・AI基本計画
- EU AI Act: 検索 `EU AI Act Article 50 2026` / EUR-Lex
