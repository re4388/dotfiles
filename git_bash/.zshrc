export ZSH=$HOME/.oh-my-zsh
export laptop=wits_git_bash


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



# binding auto suggest accept with ctrl + space
# bindkey '^ ' autosuggest-accept
bindkey '^j' autosuggest-accept


source $ZSH/oh-my-zsh.sh
