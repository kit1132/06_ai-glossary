# ソース取得フロー（用語早見表）

## 取得手順

`glossary-sources.md` の各ソースについて、記載の「取得方法」に従う。省略時は次の順。

1. **プライマリ URL を WebFetch**
2. 403 / 429 / タイムアウト → **代替 URL があれば WebFetch**
3. それでも失敗 → **WebSearch**（`site:ドメイン キーワード 当年`）
4. `site:` が 0 件 → **`site:` を外して再検索**
5. すべて失敗 → `.last-check-state.md` に到達不可と書く。`index.html` は変えない

## HTML を変えてよい条件

**公式ページの本文が WebFetch で取れたときだけ** `index.html` を変える。

WebSearch のタイトル・スニペット・第三者記事は手がかりであり、一次ではない。検索だけで料金・改名・提供終了・モデル名を断定しない。未確定として state に残す。

例外: `glossary-sources.md` が「WebSearch を先に」としているホストでも、表を変えるにはその後に公式 URL を WebFetch して本文を取る。Fetch できなければ未確定。

## 403 の切り分け

WebFetch が失敗したときだけ、切り分けに `curl` を使ってよい。

```bash
curl -sS -o /dev/null -w "%{http_code}" --max-time 25 <URL>
```

- **ゲートウェイ拒否**: exit 56 / `CONNECT tunnel failed`。許可リスト外。サイト復旧では解消しない
- **オリジン403**: HTTP 403。サイト側ブロック。WebSearch へ

`curl` の 403 だけで「WebFetch も不可」としない。WebFetch が本文を返していれば到達成功。

記録先は `.last-check-state.md`（IMPROVEMENT-BACKLOG は無い）。

## 恒久リダイレクト（301 / 308）

取得障害ではない。`glossary-sources.md` の URL を転送先に書き換えてよい。302 / 307 は対象外。

## 01_ai-news リポジトリ

clone しない。読まない。この表の一次にしない。
