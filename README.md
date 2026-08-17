# 生成AI 用語早見表

ChatGPT / Gemini / Claude / Copilot の用語対応表です。

公開ページ: https://kit1132.github.io/06_ai-glossary/

## 隔週の自動更新

Claude Code の Routines（クラウド）が公式ページを確認し、裏付けが取れた変更だけ `index.html` を直して `main` に push します。差分が無い実行も `.last-check-state.md` を commit します（生存確認）。

手順の正本はリポジトリ内です。

- `CLAUDE.md`
- `.claude/commands/biweekly-glossary-update.md`

Routines 本体はこのリポジトリにはありません。Pro 以上のアカウントで [claude.ai/code/routines](https://claude.ai/code/routines) から作ります（research preview）。

### 設定手順（一度だけ）

cron は使わない。画面の選択肢だけでよい。

1. リポジトリ `kit1132/06_ai-glossary` を追加する
2. クラウド環境のネットワークを **Full** にする（Default の Trusted のままにしない）
3. コネクタは使わないので外す
4. 頻度は **weekly**。曜日は **月曜**。時刻は **04:00**（自分のタイムゾーン。日本なら JST）
5. プロンプト:

```
Read CLAUDE.md, then read and follow .claude/commands/biweekly-glossary-update.md.

Success:
- HEAD is main (or changes reached main via the repo workflow).
- .last-check-state.md is committed with today's JST date even if index.html is unchanged.
- index.html changes only when an official page confirms them. Search-only items stay listed as 未確定.
- Do not edit CSS, byline, or the trailing script.
- git push origin HEAD:main. Do not open a PR and leave it.
```

6. 初回確認はルーチン詳細の **Run now**。一覧の緑はインフラ成功だけで、表が更新された意味ではない。transcript と `.last-check-state.md` の実行日を見る

隔週の判定は画面側ではなくリポジトリ側。毎週起動し、ISO 週が奇数の週だけ公式確認する。偶数週は心拍だけ（止まっているか分かるようにする）。

`claude/` ブランチに push された場合は `.github/workflows/claude-branch-to-main.yml` が `main` へマージします。誤更新も公開されます。
