# 生成AI 用語早見表

## 基本方針

- 出力は日本語
- 公式ページで裏付けた変更だけ `index.html` を直す
- 検索だけの手がかりは表に書かない。`.last-check-state.md` の未確定に残す
- 01_ai-news-* は clone しない（開発ツール特化で、この表の一次にならない）

## プロジェクト構成

- `index.html` — 公開している早見表本体（GitHub Pages）
- `.claude/commands/biweekly-glossary-update.md` — **隔週手順の正本**。ルーチンはこのファイルを Read して従う（slash 自動起動には頼らない）
- `.last-check-state.md` — 最終実行日・ソース到達・未確定・HTML を変えたか（心拍）
- `.claude/rules/` — ソース、取得順、スコープ、HTML 編集規則

## 実行環境

- Claude Code on the web の Routines（research preview）
- 想定: Routines は **毎週月曜 04:00 JST**（画面の weekly。cron は使わない）
- 本調査は **ISO 週が奇数の週だけ**（隔週）。偶数週は心拍のみ
- ネットワーク: **Full**（Default Trusted では公式ヘルプに届かない）
- 日付: JST。`TZ=Asia/Tokyo date +%Y-%m-%d` で取る

## ⚠️ ブランチ運用（絶対ルール）

既定では Routines は `claude/` ブランチに push する。このリポジトリは **main へ直接載せる**。

### 開始時（毎セッション必ず）

```bash
TZ=Asia/Tokyo date +%Y-%m-%d
git fetch origin main --depth=1
git checkout main
git pull --ff-only origin main
git rev-parse --abbrev-ref HEAD     # → 必ず `main`
```

`.claude/settings.json` の SessionStart hook が main checkout を試みるが、**自分でも上を実行する**。

### コミット・push（毎回必ず）

`index.html` に差分が無くても `.last-check-state.md` は更新して commit する。これを欠くと、ルーチン停止と「変更なし」が区別できない。

```bash
git add index.html .last-check-state.md .claude/rules/sites/glossary-sources.md
git commit -m "Update glossary check for YYYY-MM-DD"
git push origin HEAD:main
```

`index.html` を変えていない実行は `git add` から外してよい。state は必ず入れる。

### 禁止事項

- `git checkout -b <new-branch>`
- `git push origin <feature-branch>` だけして終わる
- PR を作って放置する
- CSS・byline・末尾 `<script>` の改変
- 公式ページなしで `index.html` を変える

`claude/**` に載った場合は `.github/workflows/claude-branch-to-main.yml` が main へマージする。誤更新も公開される。

## 成功条件

- HEAD が `main`（または workflow 経由で main に届いている）
- `.last-check-state.md` に当日 JST の実行日がある
- `index.html` の変更は公式ページで確認したものだけ
- 検索だけの項目は未確定にあり、表には無い

## ルール参照

各タスクは該当ファイルを読んでから実行する。

- `.claude/commands/biweekly-glossary-update.md` — 手順
- `.claude/rules/sites/glossary-sources.md` — 公式 URL
- `.claude/rules/sites/fetch-flow.md` — 取得順
- `.claude/rules/interests/glossary-scope.md` — 直す／足す／残す／無視
- `.claude/rules/preferences/html-edit.md` — 編集箇所と件数の数え方
