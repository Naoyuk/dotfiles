# Dotfiles

個人環境用の設定ファイル集。

## 設定ファイル
- `~/.zshrc`
- `~/.gitconfig`
- `~/.tmux.conf`
- `~/.vimrc`(`~/.config/nvim/init.vim`)
- '~/.config/wezterm/wezterm.lua'

## 使い方

```bash
ln -s ~/dotfiles/.zshrc ~/.zshrc
ln -s ~/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/.vimrc ~/.vimrc
ln -s ~/dotfiles/.config/nvim/init.vim ~/.config/nvim/init.vim
ln -s ~/dotfiles/.config/wezterm/wezterm.lua ~/.config/wezterm/wezterm.lua
```

## Vim / NeoVim
### プラグインマネージャー
`~/.vim/autoload/plug.vim`を作成する必要があります。

```bash
mkdir -p ~/.vim/autoload
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

また、`~/.vim/plugged`にプラグインがインストールされるため、ディレクトリの作成が必要です。
```bash
mkdir -p ~/.vim/plugged
```

### カラースキーム
`~/.vim/colors/`にカラースキームを保存する必要があります。

```bash
mkdir -p ~/.vim/colors
```

### undoファイル
#### vimの場合
`~/.vim/undo`に保存されます。  

#### neovimの場合
`~/.neovim/undo`に保存されます。  
