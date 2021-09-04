export ZSH="/c/Users/re438/.oh-my-zsh"

## Make Backspace and other things work in VS Code's & IntelliJ's terminals
export TERM=cygwin
export TERM=xterm
export TERM=xterm-256color
## NOTE: All 3 of the above TERM settings work for me

ZSH_THEME="ys"
RPROMPT="%{$fg[green]%}[%D{%c}]"
# ZSH_THEME="robbyrussell"

plugins=(
				git
				# zsh-autosuggestions
				# zsh-syntax-highlighting
				# zsh-completions
				)

alias v=nvim
source $ZSH/oh-my-zsh.sh

