# dotfiles

macOS / Linux 用の dotfiles。[chezmoi](https://www.chezmoi.io/) で管理。

## セットアップ（新しいマシン）

```bash
# chezmoi をインストールして適用（全自動）
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply k1rnt
```

### macOS で自動インストールされるもの
- Homebrew + Brewfile のパッケージ
- Rustup + rust-analyzer
- mise runtimes (go, java, node, php, python, ruby)
- Go tools (gopls, dlv, goimports, golangci-lint)
- Cargo tools (filetree, keifu)

### Linux (Ubuntu) で自動インストールされるもの
- apt パッケージ (zsh, fzf, vim, ripgrep, etc.)
- Starship
- Rustup + rust-analyzer
- mise runtimes
- Go tools / Cargo tools

## 含まれるファイル

| ファイル | 説明 |
|----------|------|
| `.zshrc` | fish-like な zsh 設定 (autosuggestions, syntax-highlighting, fzf) |
| `.vimrc` | vim 設定 (coc.nvim, vim-polyglot) |
| `.config/ghostty/config` | Ghostty ターミナル設定 |
| `.config/starship.toml` | Starship プロンプト設定 |
| `.config/mise/config.toml` | mise ランタイム設定 |
| `Brewfile` | Homebrew パッケージ一覧 (macOS) |

## 日常の操作

### ファイルを編集

```bash
# chezmoi 経由で編集（推奨）
chezmoi edit ~/.zshrc
```

> **注意**: `.zshrc` はテンプレート（OS分岐あり）で管理されています。
> `chezmoi add ~/.zshrc` を実行するとテンプレートが上書きされるため、
> 必ず `chezmoi edit` を使用してください。
> （誤操作防止のラッパー関数が警告を出します）

### テンプレートでないファイルを編集

```bash
# 直接編集 → chezmoi に反映
vim ~/.vimrc
chezmoi add ~/.vimrc
```

### 変更を GitHub に保存

```bash
chezmoi cd
git add -A && git commit -m "メッセージ" && git push
exit
```

### Brewfile を更新 (macOS)

```bash
# 現在インストールされているパッケージで上書き
brew bundle dump --file=~/.local/share/chezmoi/Brewfile --force

# commit & push
chezmoi cd
git add -A && git commit -m "Update Brewfile" && git push
exit
```

## .zshrc の編集について

`.zshrc` はテンプレート（`dot_zshrc.tmpl`）で管理されており、macOS / Linux で異なる設定が自動生成されます。

### 編集方法

```bash
# 必ず chezmoi edit を使う
chezmoi edit ~/.zshrc
```

### やってはいけないこと

```bash
# NG: 直接編集して chezmoi add するとテンプレートが消える
vim ~/.zshrc
chezmoi add ~/.zshrc  # テンプレートが上書きされる！
```

### テンプレートの構造

```zsh
# 共通部分（両OS）
alias g='git'

# OS分岐
{{- if eq .chezmoi.os "darwin" }}
# macOS専用の設定
{{- else if eq .chezmoi.os "linux" }}
# Linux専用の設定
{{- end }}
```

### 編集時のポイント

| 変更内容 | 編集箇所 |
|----------|----------|
| 共通の設定を追加 | OS分岐の外側に追記 |
| macOS専用の設定 | `{{- if eq .chezmoi.os "darwin" }}` ブロック内 |
| Linux専用の設定 | `{{- else if eq .chezmoi.os "linux" }}` ブロック内 |

### 誤操作防止

`.zshrc` には `chezmoi add` をラップする関数が含まれており、テンプレートファイルに対して `chezmoi add` を実行すると警告が出ます。

## よく使うコマンド

| コマンド | 説明 |
|----------|------|
| `chezmoi edit ~/.zshrc` | ファイルを編集 |
| `chezmoi add ~/.zshrc` | 変更を取り込む |
| `chezmoi diff` | 差分を確認 |
| `chezmoi apply` | 変更を適用 |
| `chezmoi cd` | ソースディレクトリに移動 |
| `chezmoi update` | リモートから pull して適用 |
