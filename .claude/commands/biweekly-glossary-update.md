# biweekly-glossary-update — 用語早見表の隔週更新

## 目的

ChatGPT / Gemini / Claude / Copilot の公式名を確認し、裏付けが取れた変更だけ `index.html` に反映する。差分が無くても心拍として `.last-check-state.md` を commit し、**今いるブランチ**へ push する。

## 前提

- タイムゾーンは JST（Asia/Tokyo）
- Routines 側は **毎週月曜 03:00**（画面の weekly。cron は使わない）
- **本調査は隔週。** `python3 scripts/glossary-cadence.py` の `DECISION` に従う。ISO 週の偶奇では決めない
- `git push origin HEAD:main` は禁止。`claude/*` 上で `git push origin HEAD` のみ
- 01/02/03 の news リポジトリは clone しない

開始前に次を読む。

1. `CLAUDE.md`
2. `.claude/rules/sites/glossary-sources.md`
3. `.claude/rules/sites/fetch-flow.md`
4. `.claude/rules/interests/glossary-scope.md`
5. `.claude/rules/preferences/html-edit.md`
6. `.last-check-state.md`

## 手順

### 1. 日付と cadence

```bash
python3 scripts/glossary-cadence.py
YEAR_MONTH=$(TZ=Asia/Tokyo date +%Y.%m)
git rev-parse --abbrev-ref HEAD
# claude/* でなければ:
# git checkout -B "claude/glossary-$(TZ=Asia/Tokyo date +%Y%m%d)"
```

- `FILES_OK=false` → 手順ファイルが clone に無い。`index.html` を触らず終了する（default branch に載っていない）
- `DECISION=HEARTBEAT` → 手順 2–4 を飛ばして手順 5 へ
- `DECISION=FULL` → 手順 2 へ

### 2. 公式ソースを確認（FULL のみ）

`glossary-sources.md` の各ソースを `fetch-flow.md` の順で当たる。

記録すること:

- 到達できた URL
- ゲートウェイ拒否 / オリジン403 / 本文取得
- 表の現行値と違う公式名、料金、終了、改名、モデル世代、§07 の日付

### 3. 差分を分類（FULL のみ）

- **公式本文あり** → `index.html` を直してよい
- **検索だけ** → 未確定。表は変えない
- **既存ベータ** → 公式が GA または終了と書くまで残す

### 4. HTML を編集する場合

`html-edit.md` に従う。触ってよい箇所以外は変えない。

`index.html` を変えたときだけ:

- `.eyebrow` を `Quick Reference / ${YEAR_MONTH}` にする
- `.mast-meta` の情報取得時点を実行日の日本語日付にする（例: 2026年8月17日）
- 件数を数え直して `.tally-n` を合わせる

HEARTBEAT では表紙日付を動かさない。

### 5. state を更新する（必須・毎週）

`.last-check-state.md` を当日分で書き直す。最低限:

- 実行日（JST）
- ISO 週（記録用。判定には使わない）
- DECISION（FULL / HEARTBEAT）
- 本調査したか（yes / skip）
- 前回本調査日（JST）: FULL で本調査したら当日。HEARTBEAT なら前回の日付を残す
- HTML を変えたか（yes / no）
- 到達できたソース（FULL のとき）
- 到達できなかったソース（種別）
- 未確定リスト
- 適用した変更の箇条書き（なければ「表の変更なし」）
- 件数（変更した場合）

### 6. commit と push（必須・毎週）

```bash
git add .last-check-state.md
# index.html を変えたときだけ
# git add index.html
# glossary-sources.md の URL を直したときだけ
# git add .claude/rules/sites/glossary-sources.md

git commit -m "Update glossary check for ${TODAY}"
git push origin HEAD
```

`HEAD:main` は付けない。`claude/` ブランチならリポジトリの workflow が main に載せる。

### 7. 報告

短く報告する。

- 実行日、DECISION、本調査したか
- HTML を変えたか
- 変えたセル（公式 URL 付き）
- 未確定
- 作業ブランチと push した ref（`git rev-parse --abbrev-ref HEAD`）

## 成功条件

- `FILES_OK=true`
- `.last-check-state.md` に当日の実行日がある
- `git push origin HEAD` した（`HEAD:main` ではない）
- 表の変更は公式ページ由来だけ（HEARTBEAT では表を変えない）
- CSS / byline / `<script>` を変えていない
