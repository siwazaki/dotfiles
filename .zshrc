autoload -U promptinit
promptinit
setopt inc_append_history
setopt share_history
setopt auto_cd
setopt auto_menu
setopt auto_list
setopt auto_param_keys

if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    IS_REMOTE=true
else
    IS_REMOTE=false
fi

source ~/.zplug/init.zsh
zstyle ':completion:*:default' menu select=1
zplug 'zsh-users/zsh-autosuggestions'
zplug 'zsh-users/zsh-completions'
zplug 'zsh-users/zsh-syntax-highlighting'
zplug "b4b4r07/enhancd", use:init.sh
zplug "mollifier/anyframe"
zplug "zsh-users/zsh-history-substring-search"
zplug "Aloxaf/fzf-tab", from:github
zplug "mafredri/zsh-async", from:github
zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme
zplug "ptavares/zsh-direnv"


if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo
        zplug install
    fi
fi

zplug load --verbose

# Ctrl+b
# fzf でディレクトリの移動履歴を表示
bindkey '^g' anyframe-widget-cdr
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

# Ctrl+r
# fzf でコマンドの実行履歴を表示
bindkey '^r' anyframe-widget-execute-history

# Ctrl+x -> Ctrl+b
# fzf でGitブランチを表示して切替え
bindkey '^x^b' anyframe-widget-checkout-git-branch

# Ctrl+x -> Ctrl+g
# GHQでクローンしたGitリポジトリを表示
bindkey '^x^g' anyframe-widget-cd-ghq-repository

export ENHANCD_FILTER=fzf
export ENHANCD_DISABLE_DOT=1
export ENHANCD_DISABLE_HOME=1

#hist file

setopt HIST_IGNORE_DUPS     # 前と重複する行は記録しない
setopt HIST_IGNORE_ALL_DUPS # 履歴中の重複行をファイル記録前に無くす
setopt HIST_IGNORE_SPACE    # 行頭がスペースのコマンドは記録しない
setopt HIST_FIND_NO_DUPS    # 履歴検索中、(連続してなくとも)重複を飛ばす
setopt HIST_REDUCE_BLANKS   # 余分な空白は詰めて記録
setopt HIST_NO_STORE        # histroyコマンドは記録しない
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
export EDITOR=emacs

export PATH="$HOME/.pyenv/shims:$PATH"
export PATH="/usr/local/cuda/bin:$PATH"

if type "pyenv" >/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi

export PATH="$HOME/.rbenv/shims:$PATH"
if type "rbenv" >/dev/null 2>&1; then
    eval "$(rbenv init -)"
fi

#export PATH="$HOME/.nodenv/shims:$PATH"
#if type "nodenv" >/dev/null 2>&1; then
#    eval "$(nodenv init -)"
#fi

export PATH="$HOME/.bin:$PATH"

#dart
export PATH="$PATH":"$HOME/.pub-cache/bin"

#flutter
export PATH="$PATH":"$HOME/fvm/default/bin"

#java
if [ -e /usr/libexec/java_home ]; then
    export JAVA_HOME=$(/usr/libexec/java_home -v "11")
fi

#android studio
export PATH="$PATH":"$HOME/Library/Android/sdk/platform-tools"
export ANDROID_HOME="$HOME/Library/Android/sdk"
export ANDROID_NDK_HOME="$HOME/Library/Android/sdk/ndk/21.4.7075529"

if type "lsd" >/dev/null 2>&1; then
    alias ls='lsd'
fi

if $IS_REMOTE; then
    zstyle :prompt:pure:host color red
fi

if [ $HOST = "nef-hidebu" ]; then
    disable-fzf-tab
fi

alias ll='ls -l'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'
alias lg='lazygit'
alias activate='source venv/bin/activate'
alias emacs='emacs -nw'
alias ta='tmux attach'
alias tat='tmux attach -t'
alias tls='tmux ls'
alias vpnup='networksetup -connectpppoeservice Nefrock && ~/.bin/add-vpn-route'
alias vpndown='networksetup -disconnectpppoeservice Nefrock'
alias sail='bash vendor/bin/sail'
alias dc='docker compose'
alias dw='docker compose exec workspace /bin/zsh'
alias sail='[ -f sail ] && bash sail || bash vendor/bin/sail'
alias flutter="fvm flutter"


#dir env
eval "$(direnv hook zsh)"

#RUST
export RUST_BACKTRACE=1

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
#source "$HOME/.rye/env"
export PATH="$HOME/.cargo/bin:$PATH"

export PATH=$HOME/.nodebrew/current/bin:$PATH

## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[[ -f /Users/siwazaki/.dart-cli-completion/zsh-config.zsh ]] && . /Users/siwazaki/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]

