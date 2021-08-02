
export ZSH=$HOME/.oh-my-zsh

# to not let tmux mess the vim color schem
export TERM=xterm-256color
export HISTCONTROL=erasedups	# when adding an item to history, delete itentical commands upstream
export HISTSIZE=10000		# save 10000 items in history

# ===============
# vim 
# ===============

#  export my_vimrc_plugin_folder=$HOME/.config/nvim/config_group
export vrc=$HOME/.config/nvim/init.vim
export vp=$HOME/.config/nvim
export VIMCONFIG=~/.config/nvim

alias v=nvim
#  alias weather='curl htt://wttr.in/New Taipei?1q'
#  alias weather='curl -4 http://wttr.in/Seattle'
alias weather="curl -H 'Accept-Language: zh' wttr.in/'${1:-New Taipei}?${2:-2q}'"




ZSH_THEME="ys"
RPROMPT="%{$fg[green]%}[%D{%c}]"

plugins=(
  git
  zsh-completions
  zsh-autosuggestions
  zsh-syntax-highlighting
  autojump
)

#  auto-fortune-cowsay




[[ -s ~/.autojump/etc/profile.d/autojump.sh ]] && . ~/.autojump/etc/profile.d/autojump.sh


alias so=source
alias ll='ls -a'
alias ..='cd ..'
alias treeless='tree -C | less -R'	# -C outputs colour, -R makes less understand color


source $ZSH/oh-my-zsh.sh
export VISUAL=nvim;
export EDITOR=nvim;

# binding auto suggest accept with ctrl + space
# bindkey '^ ' autosuggest-accept

bindkey '^f' autosuggest-accept

# ===============
# fzf
# ===============
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files'



# Mapping edit-command-line in zsh
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line
alias lg='lazygit'

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"



# deno
export DENO_INSTALL="/home/re4388/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"




# zoxide
#  zoxide import --from autojump /home/re4388/.local/share/autojump/autojump.txt
# update your PATH to use zoxide
#  export PATH="/home/re4388/.local/bin:$PATH"
#  eval "$(zoxide init --cmd j zsh)"

chpwd() {
  ls
}



# easy access to find's size search
function find_big_files() { find "${1-.}" -size +10000k -exec du -h {} \; | sort -nr; }


input_file=~/advice_db.txt
shuf -n 1 $input_file | cowsay


source ~/.local/bin/bashmarks.sh


function taocl() {
  curl -s https://raw.githubusercontent.com/jlevy/the-art-of-command-line/master/README.md |
    sed '/cowsay[.]png/d' |
    pandoc -f markdown -t html |
    xmlstarlet fo --html --dropdtd |
    xmlstarlet sel -t -v "(html/body/ul/li[count(p)>0])[$RANDOM mod last()+1]" |
    xmlstarlet unesc | fmt -80 | iconv -t US
}



#  exportf taocl
