# 生成AI 用語早見表

ChatGPT / Gemini / Claude / Copilot の用語対応表です。

公開ページ: https://kit1132.github.io/06_ai-glossary/

## 隔週の自動更新

Claude Code の Routines（クラウド）が公式ページを確認し、裏付けが取れた変更だけ `index.html` を直します。差分が無い実行も `.last-check-state.md` を commit します（生存確認）。

`claude/` ブランチへの push を `.github/workflows/claude-branch-to-main.yml` が `main` へマージします。誤更新も公開されます。

**この手順一式が `main` に無いと Routines は動けない。** clone は default branch から始まる。

手順の正本:

- `CLAUDE.md`
- `scripts/glossary-cadence.py`
- `.claude/commands/biweekly-glossary-update.md`

Routines 本体はこのリポジトリにはありません。Pro 以上のアカウントで [claude.ai/code/routines](https://claude.ai/code/routines) から作ります（research preview）。

### 設定手順（一度だけ）

cron は使わない。画面の選択肢だけでよい。

1. リポジトリ `kit1132/06_ai-glossary` を追加する
2. クラウド環境のネットワークを **Full** にする（Default の Trusted のままにしない）
3. コネクタは使わないので外す
4. 頻度は **weekly**。曜日は **月曜**。時刻は **03:00**（自分のタイムゾーン）
5. プロンプト:

```
Read CLAUDE.md. Run python3 scripts/glossary-cadence.py. Follow .claude/commands/biweekly-glossary-update.md.

Success:
- FILES_OK must be true. If not, stop without editing index.html.
- Work on a claude/glossary-YYYYMMDD branch, not main.
- .last-check-state.md is committed with today's JST date even if index.html is unchanged.
- git push origin HEAD. Never git push origin HEAD:main.
- index.html changes only when DECISION=FULL and an official page confirms them. Search-only items stay listed as 未確定.
- Do not edit CSS, byline, or the trailing script.
- Count cells are `.tally-mx` in section 00. Do not restore the cover specimen. Do not strip `&#x2060;` or `.nowrap`.
```

6. **保存済みプロンプトをこの文面に更新する**（古いプロンプトの `git push origin HEAD:main` が残っていると push が拒否される）
7. 初回確認はルーチン詳細の **Run now**。一覧の緑はインフラ成功だけで、表が更新された意味ではない。transcript と GitHub の `claude/glossary-*` ブランチ、`.last-check-state.md` の実行日を見る

隔週は cadence スクリプトが決める。前回本調査日から 13 日未満なら心拍だけ。
