######################################################
#
#    Still couple to specific computer
#
######################################################

export laptop=asus

######################################################
#
#    sync dotfiles across computers
#
######################################################


bash ~/projects/dotfiles/notice_change.sh


######################################################
#
#    env exports
#
######################################################

export ZSH=$HOME/.oh-my-zsh

# fix tmux on vim color schem
export TERM=xterm-256color
export HISTCONTROL=erasedups	# when adding an item to history, delete itentical commands upstream
export HISTSIZE=10000		# save 10000 items in history


# nvim
export vrc=$HOME/.config/nvim/init.vim
export vp=$HOME/.config/nvim
export VIMCONFIG=~/.config/nvim


export VISUAL=nvim;
export EDITOR=nvim;


# deno
export DENO_INSTALL="/home/re4388/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"


######################################################
#
#    zsh and oh-my-zsh
#
######################################################

source $ZSH/oh-my-zsh.sh


ZSH_THEME="ys"
RPROMPT="%{$fg[green]%}[%D{%c}]"

plugins=(
  git
  zsh-completions
  zsh-autosuggestions
  zsh-syntax-highlighting
  autojump
)




######################################################
#
#    alias
#
######################################################

alias v=nvim
alias weather="curl -H 'Accept-Language: zh' wttr.in/'${1:-New Taipei}?${2:-2q}'"
alias so=source
alias ll='ls -a'
alias ..='cd ..'
alias treeless='tree -C | less -R'	# -C outputs colour, -R makes less understand color
alias lg='lazygit'


######################################################
#
#    3rd tools
#
######################################################

# nvm: node version manager
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# autojump
# # -s: FILE exists and has a size greater than zero
[[ -s ~/.autojump/etc/profile.d/autojump.sh ]] && . ~/.autojump/etc/profile.d/autojump.sh

# fzf
# -f: FILE exists and is a regular file
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files'


# zoxide
#  zoxide import --from autojump /home/re4388/.local/share/autojump/autojump.txt
# update your PATH to use zoxide
#  export PATH="/home/re4388/.local/bin:$PATH"
#  eval "$(zoxide init --cmd j zsh)"


# bookmark tool
# source ~/.local/bin/bashmarks.sh
# export BASHMARKS_PREFIX="bm"


# pyenv setup
export PATH="$PYENV_ROOT/bin:$PATH"
export PYENV_ROOT="$HOME/.pyenv"
eval "$(pyenv virtualenv-init -)"
# Optional
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export PATH="$HOME/.poetry/bin:$PATH"
eval "$(pyenv init --path)"
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"


######################################################
#
#    small script
#
######################################################

# binding auto suggest accept with ctrl + space
# bindkey '^ ' autosuggest-accept

bindkey '^j' autosuggest-accept


# Mapping edit-command-line in zsh
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"


# run `ls` if changing dir
chpwd() {
  ls
}


# run cowsay from advice_db
input_file=~/advice_db.txt
shuf -n 1 $input_file | cowsay



######################################################
#
#    self-defined function
#
######################################################



# easy access to find's size search
function find_big_files() { find "${1-.}" -size +10000k -exec du -h {} \; | sort -nr; }


# function taocl() {
#   curl -s https://raw.githubusercontent.com/jlevy/the-art-of-command-line/master/README.md |
#     sed '/cowsay[.]png/d' |
#     pandoc -f markdown -t html |
#     xmlstarlet fo --html --dropdtd |
#     xmlstarlet sel -t -v "(html/body/ul/li[count(p)>0])[$RANDOM mod last()+1]" |
#     xmlstarlet unesc | fmt -80 | iconv -t US
# }

#  exportf taocl



