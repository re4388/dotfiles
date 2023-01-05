# zmodload zsh/zprof

if [[ $TERM_PROGRAM != "WarpTerminal" ]]; then
    ##### WHAT YOU WANT TO DISABLE FOR WARP - BELOW

    # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
    # Initialization code that may require console input (password prompts, [y/n]
   # confirmations, etc.) must go above this block; everything else may go below.


#    if [[ -r "${xdg_cache_home:-$home/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#      source "${xdg_cache_home:-$home/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
#    fi


    # ZSH_THEME="ys"
    # RPROMPT="%{$fg[green]%}[%D{%c}]"
    # ZSH_THEME="powerlevel10k/powerlevel10k"


    # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.

#   [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

##### WHAT YOU WANT TO DISABLE FOR WARP - ABOVE
    
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH


plugins=(git 
	zsh-autosuggestions 
	zsh-syntax-highlighting 
	fast-syntax-highlighting 
	zsh-autocomplete
	sudo
	copyfile
)


######## general setup ##########
# fix tmux on vim color schem
export TERM=xterm-256color
export HISTCONTROL=erasedups	# when adding an item to history, delete itentical commands upstream
export HISTSIZE=10000		# save 10000 items in history




####### pyenv ###############
# by default, "pyenv" and "brew" conflict on how they use PATH
# this alias will ensure brew work correctly
alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew'

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"


####### NVM #######
#
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# nvm use v12.22.0


###### Auto jump ########

[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh



##################### pet ##############
# to help me to add a new command to pet
function prev() {
  PREV=$(fc -lrn | head -n 1)
  sh -c "pet new `printf %q "$PREV"`"
}

# Select snippets at the current line (like C-r)
function pet-select() {
  BUFFER=$(pet search --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle redisplay
}
zle -N pet-select
stty -ixon
bindkey '^s' pet-select

##########################################




##################### nvim ###################
export VISUAL=nvim;
export EDITOR=nvim;

###################### mitmproxy ######################
 



################# navi as shelkl widget ###############
# allow you to use ctrl+g to active the navi
eval "$(navi widget zsh)"


########### thefuck, a tool to help fix wrong command ##########
# eval $(thefuck --alias)



############ Warp ##################

# add workflow yaml file into ~/.warp/worflows floder
# and ready to edit it
function addw() {    
    # dt = date +"%Y_%m_%d-%H_%M_%S"
    # new_file = $dt_workflow.yaml
    cp ~/.warp/workflows/work_flow_template.yaml ~/.warp/workflows/$1.yaml && echo "$1 is created"
    
    echo "begin to edit"
    echo "vi ~/.warp/workflows/$1.yaml" 
}


############### gcloud #######################
#
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/re4388/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/re4388/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/re4388/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/re4388/google-cloud-sdk/completion.zsh.inc'; fi




##################### pipx 

autoload -U bashcompinit
bashcompinit
eval "$(register-python-argcomplete pipx)"



#################### br (replace tree)
source /Users/re4388/.config/broot/launcher/bash/br





############## conda #######################

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/re4388/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/re4388/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/re4388/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/re4388/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


# base is not be activated on startup
set the auto_activate_base parameter to false



############# pipx ##################

# ensure path
# Created by `pipx` on 2023-01-01 00:01:40
export PATH="$PATH:/Users/re4388/.local/bin"


############# oh-my-zsh #############
export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh


### this shall be at end of this file #######
##########startship #########
eval "$(starship init zsh)"


################## cosay froom my advice ###############
input_file=~/project/personal/advice-db/db0.txt
shuf -n 1 $input_file | cowsay

# nvm use v12.22.0


###-begin-pm2-completion-###
### credits to npm for the completion file model
#
# Installation: pm2 completion >> ~/.bashrc  (or ~/.zshrc)
#

COMP_WORDBREAKS=${COMP_WORDBREAKS/=/}
COMP_WORDBREAKS=${COMP_WORDBREAKS/@/}
export COMP_WORDBREAKS

if type complete &>/dev/null; then
  _pm2_completion () {
    local si="$IFS"
    IFS=$'\n' COMPREPLY=($(COMP_CWORD="$COMP_CWORD" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           pm2 completion -- "${COMP_WORDS[@]}" \
                           2>/dev/null)) || return $?
    IFS="$si"
  }
  complete -o default -F _pm2_completion pm2
elif type compctl &>/dev/null; then
  _pm2_completion () {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       pm2 completion -- "${words[@]}" \
                       2>/dev/null)) || return $?
    IFS="$si"
  }
  compctl -K _pm2_completion + -f + pm2
fi
###-end-pm2-completion-###



# zprof

