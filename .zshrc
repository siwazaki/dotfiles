autoload -U promptinit; promptinit
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

zplug "junegunn/fzf-bin", as:command, from:gh-r, rename-to:fzf
zplug 'zsh-users/zsh-autosuggestions'
zplug 'zsh-users/zsh-completions'
zplug 'zsh-users/zsh-syntax-highlighting'
zplug "b4b4r07/enhancd", use:init.sh
zplug "mollifier/anyframe"
zplug "zsh-users/zsh-history-substring-search"
zplug "Aloxaf/fzf-tab", from:github
zplug "mafredri/zsh-async", from:github
zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme
zplug "knu/zsh-manydots-magic", use:manydots-magic, defer:2

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load --verbose

# Ctrl+x -> b
# fzf でディレクトリの移動履歴を表示
bindkey '^g' anyframe-widget-cdr
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

# Ctrl+x -> r
# fzf でコマンドの実行履歴を表示
bindkey '^r' anyframe-widget-execute-history

# Ctrl+x -> Ctrl+b
# fzf でGitブランチを表示して切替え
bindkey '^x^b' anyframe-widget-checkout-git-branch

# Ctrl+x -> g
# GHQでクローンしたGitリポジトリを表示
bindkey '^x^g' anyframe-widget-cd-ghq-repository

export ENHANCD_FILTER=fzf
export ENHANCD_DISABLE_DOT=1
export ENHANCD_DISABLE_HOME=1
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

export PATH="$HOME/.pyenv/shims:$PATH"
if type "pyenv" > /dev/null 2>&1; then
    eval "$(pyenv init -)"
fi    

export PATH="$HOME/.rbenv/shims:$PATH"
if type "rbenv" > /dev/null 2>&1; then
    eval "$(rbenv init -)"
fi

export PATH="$HOME/.nodenv/shims:$PATH"
if type "nodenv" > /dev/null 2>&1; then
    eval "$(nodenv init -)"
fi

export PATH="$HOME/.bin:$PATH"


if type "lsd" > /dev/null 2>&1; then
    alias ls='lsd'
fi

if $IS_REMOTE; then
    zstyle :prompt:pure:host color red
else
    #dart
    export PATH="$PATH":"$HOME/.pub-cache/bin"
    #flutter
    export PATH="$PATH":"$HOME/fvm/default/bin"
    #java
    export JAVA_HOME=$(/usr/libexec/java_home -v "1.8")
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

