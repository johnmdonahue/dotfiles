source ~/.env

#############
#  general  #
#############
export EDITOR="vim"
export HISTCONTROL=ignoredups
# tab complete cycles matches without menu
setopt menucomplete
setopt noautolist
# up / down searches history
bindkey '\e[A' history-beginning-search-backward
bindkey '\e[B' history-beginning-search-forward

############
#  prompt  #
############
# ⟿  ▲ ↬ ⤜ ☈ ◉
autoload -U promptinit; promptinit
zstyle :prompt:pure:path color white
zstyle ':prompt:pure:prompt:*' color cyan
PURE_PROMPT_SYMBOL=▲
prompt pure

#############
#  aliases  #
#############
alias l='ls -lAhFG'
alias ..='cd ..'
alias notes='code ~/Library/Mobile\ Documents/com~apple~CloudDocs/Notes'
alias g='git status'
alias gl='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset" --abbrev-commit --date=relative'
alias gad='git add .'
alias gcl='git clone'
alias gcm='git commit -m'
alias gco='git checkout'
alias gd='git diff'
alias gds='git diff --staged'
alias gdr='git diff origin/master HEAD'
alias gpull='git pull'
alias gpush='git push'
alias gsp='git stash && git pull && git stash pop'
