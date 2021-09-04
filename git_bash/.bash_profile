## Created: 2021-08-30

## Use `gvim filename` to edit filename with GUI Vim
alias v='nvim'

## Use `cdi` to cd to the Infinite Ink project root
## Note I set INFINITEINKROOT environment variable via Control Panel
# alias cdi="cd `cygpath $INFINITEINKROOT`"

## Do not let me overwrite a file with > redirection
set -o noclobber

## Make Backspace and other things work in VS Code's & IntelliJ's terminals
# export TERM=cygwin
# export TERM=xterm
# export TERM=xterm-256color
## NOTE: All 3 of the above TERM settings work for me

# Set the base PS1
# export PS1="\t: \W$ "

# Source the git bash completion file
if [ -f ~/.git-completion.bash ]; then
    source ~/.git-completion.bash
    source ~/.git-prompt.bash
    PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
fi


# export PS1

# Launch Zsh
if [ -t 1 ]; then
exec zsh
fi
