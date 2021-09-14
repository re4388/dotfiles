export ZSH=$HOME/.oh-my-zsh
export laptop=asus_git_bash
## cygwin is window-quasi-posix system
## Must use this term to make terminal work with zsh 
export TERM=cygwin

ZSH_THEME="ys"
RPROMPT="%{$fg[green]%}[%D{%c}]"

plugins=(
				git
				zsh-autosuggestions
				zsh-syntax-highlighting
				zsh-completions
				)

alias v=nvim
alias so=source
alias ll='ls -a'
alias ..='cd ..'

source $ZSH/oh-my-zsh.sh
