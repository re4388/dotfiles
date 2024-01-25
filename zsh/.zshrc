######## profile code at top ############

# zmodload zsh/datetime
# setopt PROMPT_SUBST
# PS4='+$EPOCHREALTIME %N:%i> '
#
# logfile=$(mktemp zsh_profile.7Pw1Ny0G)
# echo "Logging to $logfile"
# exec 3>&2 2>$logfile
#
# setopt XTRACE

######## profile code at top ############



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

 	# fast-syntax-highlighting
	# sudo
  ## copyfile

        # zsh-vi-mode

plugins=(
        pyenv-lazy
        zshfl
        git
        zsh-autocomplete
  	    zsh-syntax-highlighting
        zsh-autosuggestions
        zsh-kubectl-prompt
        you-should-use
        command-not-found
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



#############    node.js 相關 #########################



########################## fnm(rust version of nvm, faster) ###########
eval "$(fnm env --use-on-cd)"




################## nvm ####################

# export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
#
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Put this into your $HOME/.zshrc to call nvm use automatically whenever you enter a directory that contains an .nvmrc file with a string telling nvm which node to use:





# load-nvmrc() {
#   local nvmrc_path
#   nvmrc_path="$(nvm_find_nvmrc)"
#
#   if [ -n "$nvmrc_path" ]; then
#     local nvmrc_node_version
#     nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")
#
#     if [ "$nvmrc_node_version" = "N/A" ]; then
#       nvm install
#     elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
#       nvm use
#     fi
#   elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
#     echo "Reverting to nvm default version"
#     nvm use default
#   fi
# }
# add-zsh-hook chpwd load-nvmrc
# load-nvmrc

# place this after nvm initialization!
autoload -U add-zsh-hook


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


################### function ####################3

google() {
    if [ -z "$1" ]; then
        echo "Usage: google <query>"
    else
        query="$1"
        open "https://www.google.com/search?q=$query"
    fi
}


# Define the function



function qq {
  # get the scripts, fzf, use awk to append bun run and path, then copy into system clipboard
  ls /Users/re4388/project/personal/lang/bun/bun_cli_0/scripts | fzf | awk '{print "bun /Users/re4388/project/personal/lang/bun/bun_cli_0/scripts/"$1}' | pbcopy
  echo -e "\e[1;34m"~~command copied to the clipboard~~"\e[0m"

}

function ben {
  # get the scripts, fzf, use awk to append bun run and path, then copy into system clipboard
  ls /Users/re4388/project/personal/lang/bun/bun_cli_0/scripts | fzf | awk '{print "bun /Users/re4388/project/personal/lang/bun/bun_cli_0/scripts/"$1}' | (zsh)
}

# function ben1 {
#   # get the scripts, fzf, use awk to append bun run and path, then copy into system clipboard
#   ls /Users/re4388/project/personal/lang/bun/bun_cli_0/scripts | fzf |  awk '{print "/Users/re4388/project/personal/lang/bun/bun_cli_0/scripts/"$1}' | xargs -0 -o bun
#
# }




##################### vim related ###################
export VISUAL=lvim;
export EDITOR=lvim;

alias vi=lvim
alias vim=lvim
alias nvim=lvim
###################### mitmproxy ######################




################# navi as shelkl widget ###############
# allow you to use ctrl+g to active the navi
# eval "$(navi widget zsh)"




########### thefuck, a tool to help fix wrong command ##########
# note: make cold start slow and seldom use -> remove
# eval $(thefuck --alias)






############ Warp ##################

# add workflow yaml file into ~/.warp/worflows floder
# and ready to edit it
# function addw() {
    # dt = date +"%Y_%m_%d-%H_%M_%S"
    # new_file = $dt_workflow.yaml
 #    cp ~/.warp/workflows/work_flow_template.yaml ~/.warp/workflows/$1.yaml && echo "$1 is created"
  #
   #  echo "begin to edit"
    # echo "vi ~/.warp/workflows/$1.yaml"
# }


############### gcloud #######################
#
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/re4388/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/re4388/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/re4388/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/re4388/google-cloud-sdk/completion.zsh.inc'; fi




##################### pipx  ###################

### note: 影響 cold start, 先關掉，有常用再開

# autoload -U bashcompinit
# bashcompinit
# eval "$(register-python-argcomplete pipx)"

#################### br (replace tree)
# source /Users/re4388/.config/broot/launcher/bash/br



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
# input_file=~/project/personal/advice-db/db0.txt
# shuf -n 1 $input_file | cowsay
# shuf -n 1 $input_file

q0=/Users/re4388/Library/CloudStorage/Dropbox/ben_personal/personal/career/quote_JordanBPeterson.txt
shuf -n 1 $q0



###-begin-pm2-completion-###
### credits to npm for the completion file model
#
# Installation: pm2 completion >> ~/.bashrc  (or ~/.zshrc)
# below the code begin:


# COMP_WORDBREAKS=${COMP_WORDBREAKS/=/}
# COMP_WORDBREAKS=${COMP_WORDBREAKS/@/}
# export COMP_WORDBREAKS
#
# if type complete &>/dev/null; then
#   _pm2_completion () {
#     local si="$IFS"
#     IFS=$'\n' COMPREPLY=($(COMP_CWORD="$COMP_CWORD" \
#                            COMP_LINE="$COMP_LINE" \
#                            COMP_POINT="$COMP_POINT" \
#                            pm2 completion -- "${COMP_WORDS[@]}" \
#                            2>/dev/null)) || return $?
#     IFS="$si"
#   }
#   complete -o default -F _pm2_completion pm2
# elif type compctl &>/dev/null; then
#   _pm2_completion () {
#     local cword line point words si
#     read -Ac words
#     read -cn cword
#     let cword-=1
#     read -l line
#     read -ln point
#     si="$IFS"
#     IFS=$'\n' reply=($(COMP_CWORD="$cword" \
#                        COMP_LINE="$line" \
#                        COMP_POINT="$point" \
#                        pm2 completion -- "${words[@]}" \
#                        2>/dev/null)) || return $?
#     IFS="$si"
#   }
#   compctl -K _pm2_completion + -f + pm2
# fi

###-end-pm2-completion-###

#eval "$(zoxide init zsh)"




###### Auto jump ########

# [ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh
# export SSLKEYLOGFILE=~/sslkeylogfile/keylogfile.log


########## add go/bin into path
export PATH=$PATH:/Users/re4388/go/bin


## ########## k8s ###############
alias kc=kubectl
alias minik=minikube
alias kctx=kubectx


################ git ###################

function gitbk () {
  git switch -c backup_$(date +"_%Y_%m_%d_%H_%M_%S")
}



# auto complete
if [ $commands[kubectl] ]; then source <(kubectl completion zsh); fi



# a script to ssh into many wemo service
# need to git clone https://athena.wemoscooter.com/wemo/ssh-gcp first
# alias wemogcp="/Users/re4388/project/work/ssh-gcp/ssh-gcp.sh"

# binding auto suggest accept with ctrl + space
# ^ is ctrl
# bindkey '^ ' autosuggest-accept
# bindkey '^b' autosuggest-accept
# bindkey '^[f' autosuggest-accept




# eval AI_AC_ZSH_SETUP_PATH=/Users/re4388/Library/Caches/ai/autocomplete/zsh_setup && test -f $AI_AC_ZSH_SETUP_PATH && source $AI_AC_ZSH_SETUP_PATH; # ai autocomplete setup


# export andriod build-tools
# export PATH=/Users/re4388/Library/Android/sdk/build-tools/30.0.2


# perl5
# PATH="/Users/re4388/perl5/bin${PATH:+:${PATH}}"; export PATH;
# PERL5LIB="/Users/re4388/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
# PERL_LOCAL_LIB_ROOT="/Users/re4388/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
# PERL_MB_OPT="--install_base \"/Users/re4388/perl5\""; export PERL_MB_OPT;
# PERL_MM_OPT="INSTALL_BASE=/Users/re4388/perl5"; export PERL_MM_OPT;

# add kit bin into path, scriptkit, https://www.scriptkit.com/
export PATH="$PATH:/Users/re4388/.kit/bin"


# autoload -U compinit && compinit
fpath=($ZSH/custom/completions $fpath)


# IDEA open, like `code` for vscode
alias idea='open -na "IntelliJ IDEA.app" --args'


alias du='gdu-go'


# https://github.com/superbrothers/zsh-kubectl-prompt
# display current k8s context
RPROMPT='%{$fg[blue]%}($ZSH_KUBECTL_PROMPT)%{$reset_color%}'




# bindkey '\t' menu-select "$terminfo[kcbt]" menu-select
# bindkey -M menuselect '\t' menu-complete "$terminfo[kcbt]" reverse-menu-complete
# bindkey '\t'  autosuggest-accept
# bindkey '\t' menu-complete
# bindkey '^s' pet-select

# [ -f ~/.inshellisense/key-bindings.zsh ] && source ~/.inshellisense/key-bindings.zshexport


# psql
PATH="/opt/homebrew/opt/libpq/bin:$PATH"


# https://atuin.sh/docs/key-binding#disable-up-arrow
# Bind up-arrow but not ctrl-r
eval "$(atuin init zsh --disable-ctrl-r)"
eval "$(zoxide init zsh)"




# bun completions
[ -s "/Users/re4388/.bun/_bun" ] && source "/Users/re4388/.bun/_bun"






#########  profile code at bottom ###########
######### ref: https://blog.skk.moe/post/make-oh-my-zsh-fly/

# unsetopt XTRACE
# exec 2>&3 3>&-
