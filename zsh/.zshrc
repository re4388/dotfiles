
export ZSH=$HOME/.oh-my-zsh

# to not let tmux mess the vim color schem
export TERM=xterm-256color


# ===============
# vim 
# ===============


#  export my_vimrc_plugin_folder=$HOME/.config/nvim/config_group

export vrc=$HOME/.config/nvim/init.vim
export vp=$HOME/.config/nvim
export VIMCONFIG=~/.config/nvim

alias v=nvim
# alias lv2=nvim -u ~/.config/nvim2/init.vim
#  alias nvim1="nvim -u ~/.config/nvim1/init.vim"
#  alias nvim2="nvim -u ~/.config/nvim2/init.vim"



ZSH_THEME="ys"
plugins=(git zsh-completions zsh-autosuggestions zsh-syntax-highlighting autojump)
[[ -s ~/.autojump/etc/profile.d/autojump.sh ]] && . ~/.autojump/etc/profile.d/autojump.sh


alias so=source
alias ll='ls -a'



source $ZSH/oh-my-zsh.sh
export VISUAL=nvim;
export EDITOR=nvim;

# binding auto suggest accept with ctrl + space
# bindkey '^ ' autosuggest-accept

bindkey '^E' autosuggest-accept

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
