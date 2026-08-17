# 生成AI 用語早見表

## 基本方針

- 出力は日本語
- 公式ページで裏付けた変更だけ `index.html` を直す
- 検索だけの手がかりは表に書かない。`.last-check-state.md` の未確定に残す
- 01_ai-news-* は clone しない（開発ツール特化で、この表の一次にならない）

## プロジェクト構成

- `index.html` — 公開している早見表本体（GitHub Pages）
- `scripts/glossary-cadence.py` — FULL（本調査）か HEARTBEAT かを決める
- `.claude/commands/biweekly-glossary-update.md` — 隔週手順の正本
- `.last-check-state.md` — 最終実行日・ソース到達・未確定・HTML を変えたか（心拍）
- `.claude/rules/` — ソース、取得順、スコープ、HTML 編集規則

これらのファイルが clone に無い実行は失敗。default branch（`main`）へ載せる前に Routines を回さない。

## 実行環境

- Claude Code on the web の Routines（research preview）
- 想定: Routines は **毎週月曜 03:00**（画面の weekly。時刻はアカウントのローカルゾーン）
- 本調査は **前回本調査日から 13 日未満ならスキップ**（隔週）。ISO 週の奇数／偶数では決めない
- ネットワーク: **Full**（Trusted の既定許可リストに openai.com / claude.com / learn.microsoft.com は含まれない）
- 日付: JST。判定は `python3 scripts/glossary-cadence.py`

## ⚠️ ブランチ運用（絶対ルール）

クラウドは `claude/` 接頭辞のブランチにだけ載せる。clone 開始は `main` なので、**先に `claude/glossary-YYYYMMDD` へ移る**。`git push origin HEAD:main` は使うな。GitHub プロキシは現在ブランチへの push だけ通し、`claude/` 以外は拒否されうる。

### 開始時

```bash
python3 scripts/glossary-cadence.py
# SessionStart hook がクラウドでは claude/glossary-YYYYMMDD を切る
git rev-parse --abbrev-ref HEAD   # claude/* であること
```

`DECISION=FULL` なら本調査。`HEARTBEAT` なら公式確認をせず心拍だけ。`FILES_OK=false` ならここで止める。

HEAD が `claude/` でなければ:

```bash
git checkout -B "claude/glossary-$(TZ=Asia/Tokyo date +%Y%m%d)"
```

`main` のまま commit / push しない。

### コミット・push（毎回必ず）

`.last-check-state.md` は HTML 不変でも更新して commit する。

```bash
git add .last-check-state.md
# index.html を変えたときだけ git add index.html
# glossary-sources.md の URL を直したときだけ git add .claude/rules/sites/glossary-sources.md
git commit -m "Update glossary check for YYYY-MM-DD"
git push origin HEAD
```

`claude/` に載った変更は `.github/workflows/claude-branch-to-main.yml` が `main` へマージする。誤更新も公開される。

### 禁止事項

- `git push origin HEAD:main`
- `git checkout main` してから作業する（プロキシが今のブランチ以外へ push できない）
- PR を作って放置する
- CSS・byline・末尾 `<script>` の改変
- 公式ページなしで `index.html` を変える
- `html-edit.md` に無い構造を足す（表紙標本の復活など）

## 成功条件

- `python3 scripts/glossary-cadence.py` が `FILES_OK=true` を出した
- `.last-check-state.md` に当日 JST の実行日がある
- 現在ブランチへ `git push origin HEAD` した（`HEAD:main` ではない）
- `index.html` の変更は公式ページで確認したものだけ（HEARTBEAT では表を変えない）
- 検索だけの項目は未確定にあり、表には無い

## ルール参照

- `.claude/commands/biweekly-glossary-update.md` — 手順
- `.claude/rules/sites/glossary-sources.md` — 公式 URL
- `.claude/rules/sites/fetch-flow.md` — 取得順
- `.claude/rules/interests/glossary-scope.md` — 直す／足す／残す／無視
- `.claude/rules/preferences/html-edit.md` — 編集箇所と件数の数え方
