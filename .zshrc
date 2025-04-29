export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

eval "$(rbenv init -)"

# Complement
autoload -Uz compinit && compinit
setopt auto_list
setopt auto_menu
setopt auto_cd

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# History setting
HISTFILE=$HOME/.zsh-history
export HISTSIZE=100000
export SAVEHIST=100000
setopt share_history

# 直前のコマンドの重複を削除
setopt hist_ignore_dups

# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups

# エイリアス
alias runs='python manage.py runserver'
alias g='git'
alias dk='docker'
alias d-c='docker-compose'
alias ls='ls --color'

# git
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{magenta}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{yellow}"
zstyle ':vcs_info:*' formats "%F{cyan}%c%u(%b)%f"
zstyle ':vcs_info:*' actionformats '(%b|%a)'
precmd () { vcs_info }

# プロンプトカスタマイズ
PROMPT='
%F{blue}%c:%F{cyan}$vcs_info_msg_0_%f %F{yellow}$%f '

# $PATH
# export PATH=/usr/local/Cellar/vim/8.2.2250_1/bin:$PATH

# Python3.10 PATH
export PATH=/opt/homebrew/Cellar/python@3.10//3.10.4/bin:$PATH

# rbenv PATH
export PATH="~/.rbenv/shims:/usr/local/bin:$PATH"
eval "$(rbenv init -)"

# postgresql data storage
export PGDATA=/usr/local/var/postgres

# go PATH
export PATH=$PATH:$HOME/go/bin

# XDG configurationのHome Path
export XDG_CONFIG_HOME=$HOME/.config

# Deno PATH
export PATH=$PATH:$HOME/.deno/bin

# Fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source /opt/homebrew/Cellar/fzf/0.60.3/shell/key-bindings.zsh
source /opt/homebrew/Cellar/fzf/0.60.3/shell/completion.zsh

# typescript PATH
export PATH=/Users/naoyuki/lerning/typescript/node_modules/.bin:$PATH

# Android SDK PATH
export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_SDK_ROOT/emulator
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools

# execute tmux only boot the terminal
# if [ $SHLVL = 1 ]; then
#   tmux
# fi
