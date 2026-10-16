# Sprint N 契約 — 公式裏付けのある用語早見表を公開面で保つ

対象 URL: https://kit1132.github.io/06_ai-glossary/  
実体: リポジトリ直下 `index.html`（GitHub Pages）

本ファイルはスプリント契約ひな形。例・デフォルト対象は用語早見表ページ。習慣アプリ（CRUD / `apps/web` / `ht:v1`）は対象にしない。習慣 Sprint 1 の契約本文は `docs/sprint-01-contract.md` に残す。

**合格条件**: 前提 PN-01〜04 と受け入れ CN-01〜12 をすべて満たす。1 つの ID でも未達なら **不合格**。

## 用語

- **公開面:** https://kit1132.github.io/06_ai-glossary/ 。リポジトリ直下 `index.html` と同一の早見表
- **UI 正本相当:** `index.html` の `:root`（`--paper` `#F0E4DA`、`--ink` `#31261F`）と `.claude/rules/preferences/html-edit.md` の触ってよい／いけない。新規 `ui-design` で用語表の見た目を作り直さない。用語表は YAML `status: approved` の新規 UI 正本を要求しない
- **表:** §02〜§07 のセル・定義・日付付き事実。§00 の案内文（ケース案内・読み方）は html-edit.md で触ってはいけない
- **公式ページ:** `.claude/rules/sites/glossary-sources.md` に列挙する各社公式 URL。WebSearch のヒットだけでは表を変えない
- **未確定:** `.last-check-state.md` の見出し「未確定」。表には書かない
- **手動:** エバリュエーターが実ブラウザで公開面を操作する。頭の中の操作は未達
- **目視+計測:** 同じ実ブラウザで DevTools を使う。数値条件を目視だけにしない
- **ファイル:** リポジトリ上の該当ファイルを読む
- **コマンド:** リポジトリ直下で実行。`FILES_OK=false` は PN-02 未達

## 前提

| # | 条件 | 観察者 | 検証方法 |
|---|------|--------|----------|
| PN-01 | 用語表の UI 正本相当は `index.html` の `:root`（`--paper` が `#F0E4DA`、`--ink` が `#31261F`）と `.claude/rules/preferences/html-edit.md`。html-edit.md に「触ってよい」「触ってはいけない」がある。`docs/ui-design.md` を用語表の見た目正本にしていない | エバリュエーター | ファイル |
| PN-02 | リポジトリ直下 `python3 scripts/glossary-cadence.py` 終了コード 0。標準出力に `FILES_OK=true` がある | エバリュエーター | コマンド |
| PN-03 | 編集規則の正本が `.claude/rules/preferences/html-edit.md` にある。件数の数え方の表がある | エバリュエーター | ファイル |
| PN-04 | 公開面の実装パスがリポジトリ直下 `index.html` である。`apps/web/` を用語表の実装エントリにしていない | エバリュエーター | ファイル |

PN-02 は CN-01〜12 の代替にしない。

## 受け入れ条件

| # | 条件 | 観察者 | 検証方法 |
|---|------|--------|----------|
| CN-01 | 公開面 https://kit1132.github.io/06_ai-glossary/ が開き、見出しが「生成AI 用語早見表」。節番号 01〜07 が画面にある | エバリュエーター | 手動（実ブラウザ） |
| CN-02 | 表セル（§02 の `span.term` / `span.gloss`、§03 の `term` / `gloss`、§04 のプラン名と `span.price`、§05 の `tbody tr`、§06 の `.def`、§07 の日付付き事実）を変えたとき、各変更に公式ページ URL がある。公式ページ無しの表セル変更は無い。表を変えない実行では、表セルはスプリント開始時と同一 | エバリュエーター | ファイル |
| CN-03 | 検索だけの手がかりは表に無い。未確定の項目は `.last-check-state.md` の「未確定」にある | エバリュエーター | ファイル |
| CN-04 | `<style>`（印刷用 CSS を含む）がスプリント開始時の `index.html` と同一 | エバリュエーター | ファイル |
| CN-05 | `.byline` がスプリント開始時と同一。X リンクは `https://x.com/kit_1132`。`.byline-ico` がある | エバリュエーター | ファイル |
| CN-06 | 末尾 `<script>`（検索・印刷・HTML保存）がスプリント開始時と同一 | エバリュエーター | ファイル |
| CN-07 | HTML 本文（`<style>` の外）に class `specimen` の要素が無い。`<style>` 内の `.specimen` 規則は触らない | エバリュエーター | ファイル |
| CN-08 | 本文を書き換えた箇所で、書き換え前にあった `&#x2060;` と class `nowrap` が同じ箇所に残っている。書き換え前に無い印を新しい class として足していない | エバリュエーター | ファイル |
| CN-09 | `.tally-mx` の数字が html-edit.md の数え方と一致する。(1) やりたいこと = 見出し「やりたいこと → 4社の呼び名」の `tbody tr` 数 (2) 4社の呼び名 = 同表で `span.term` があるセル数（提供終了でも term があれば数える。gloss だけと `span.none` は数えない） (3) 共通のことば = §06 の `div.def` 数 (4) 改名の記録 = §05 の `tbody tr` 数 (5) 合計 = 上4つの和。`.tally-mx` の計セルとキャプションの数字が (1)〜(5) と一致する | エバリュエーター | ファイル |
| CN-10 | `body` の computed `background-color` が `#F0E4DA`（rgb(240, 228, 218)）。`body` の computed `color` が `#31261F`（rgb(49, 38, 31)） | エバリュエーター | 目視+計測（DevTools） |
| CN-11 | 検索窓 `[data-search]` に「キャンバス」と入れると、該当しない `[data-row]` が非表示になり、該当する行が残る。空に戻すと行が再表示される。会社チップ `button.chip[data-v]` を 1 つ押すと、その社以外の `[data-v]` の不透明度が下がる。もう一度押すと戻る | エバリュエーター | 手動（実ブラウザ） |
| CN-12 | 次をすべて満たす。1 つでも欠けたら CN-12 は未達。(1) html-edit.md に無い新しい class が無い (2) レイアウト用 class（`tbl` / `h-v` / `data-v` / `data-row`）の付け方がスプリント開始時と同一 (3) `.brand` の data URI がスプリント開始時と同一 (4) §00 の案内文（ケース案内・読み方）がスプリント開始時と同一 (5) `.eyebrow`（`Quick Reference / YYYY.MM`）と `.mast-meta` の「情報取得時点」は、`index.html` を変えた実行だけ実行日の JST に更新されている。表を変えない実行では表紙日付はスプリント開始時と同一 | エバリュエーター | ファイル |

## スコープ外（Sprint N）

- 習慣アプリの機能追加（CRUD、日次チェック、永続化、`apps/web`、`ht:v1`）
- 52 週ヒートマップ
- CSS 全面改修（`<style>` の書き換え）
- byline 変更（X リンク、アイコン）
- 末尾 `<script>` の改変
- 表紙標本（`.specimen`）の復活
- 新規 ui-design で用語表の見た目を作り直すこと
- 公式ページ無しの表セル追加
- 検索だけの手がかりを表に書くこと
- Cursor / Devin 等、4 社の外の新規列
- `01_ai-news-*` の clone
- 習慣アプリの GitHub Pages 公開
