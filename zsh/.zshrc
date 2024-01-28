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
plugins=(
# fast-syntax-highlighting
# sudo
# copyfile
# zsh-vi-mode

    # autoload -uz compinit 移動到這邊管理，一天只跑一起 補全載入
    # /Users/re4388/.oh-my-zsh/plugins/zshfl/zshfl.plugin.zsh
    zshfl

    # 缓存 eval
    # https://github.com/mroth/evalcache
    # use _evalcache to replace eval
    evalcache

    pyenv-lazy

    git
    zsh-kubectl-prompt
    you-should-use
    command-not-found

#     fzf-tab

#     zsh-autocomplete  # 跟 fzf-autocomplete 衝到

    zsh-autosuggestions
    zsh-syntax-highlighting
)


############# oh-my-zsh #############
export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh




############ zsh completion #############
# https://thevaluable.dev/zsh-completion-guide-examples

# 使用上面的 zshfl 取代
# autoload -U compinit && compinit
# fpath=($ZSH/custom/completions $fpath)



######## general setup ##########
# fix tmux on vim color schem
export TERM=xterm-256color
export HISTCONTROL=erasedups	# when adding an item to history, delete itentical commands upstream
export HISTSIZE=10000		# save 10000 items in history







################### fzf ####################

# 換成更高效的查詢引擎
# export FZF_DEFAULT_COMMAND='rg --files --hidden'
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'

# Use ~~ as the trigger sequence instead of the default **
export FZF_COMPLETION_TRIGGER='~~'
# export FZF_COMPLETION_DIR_COMMANDS="cd pushd rmdir tree"
# export FZF_COMPLETION_TRIGGER="**"

# key bindings and fuzzy completion
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# key bindings:
# CTRL-T - Paste the selected files and directories onto the command-line
export FZF_CTRL_T_OPTS="--height 60% \
--border sharp \
--layout reverse \
--prompt '∷ ' \
--pointer ▶ \
--marker ⇒"


# CTRL-R - Paste the selected command from history onto the command-line
# ALT-C - cd into the selected directory



# 目前 fzf 的 completion 跟 zsh-autocomplete 衝到, 因此不起作用
# 我用 zsh-autocomplete, 因為後者的功能比較全面

# fuzzy completion:
# - You can select multiple items with TAB key
# vi ~~<TAB>
# kill -9
# export ~~
# unset	~~
# export FZF_COMPLETION_DIR_COMMANDS="cd pushd rmdir tree"

#  to specify shell commands that should be used by fzf (Fuzzy Finder) for directory completion
# export FZF_COMPLETION_DIR_COMMANDS="fd --type d"

_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}


#
# # try build a simple completion
# _fzf_complete_git() {
#   _fzf_complete -- "$@" < <(
#     git --help -a | grep -E '^\s+' | awk '{print $1}'
#   )
# }
#
#
# _fzf_comprun() {
#   local command=$1
#   shift
#
#   case "$command" in
#     tree)         find . -type d | fzf --preview 'tree -C {}' "$@";;
#     *)            fzf "$@" ;;
#   esac
# }


################################ alias
source /Users/re4388/project/personal/my-github-pjt/dotfiles/zsh/alias.zsh




###################### export, env variables ######################

export VISUAL=nvim;
export EDITOR=nvim;






############### gcloud #######################
#
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/re4388/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/re4388/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/re4388/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/re4388/google-cloud-sdk/completion.zsh.inc'; fi




############## conda #######################

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/re4388/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
    _evalcache $__conda_setup
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




### this shall be at end of this file #######
##########startship #########
eval "$(starship init zsh)"
# _evalcache starship init zsh


################## cosay froom my advice ###############
# input_file=~/project/personal/advice-db/db0.txt
# shuf -n 1 $input_file | cowsay
# shuf -n 1 $input_file

q0=/Users/re4388/Library/CloudStorage/Dropbox/ben_personal/personal/career/quote_JordanBPeterson.txt
shuf -n 1 $q0





########################## fnm(rust version of nvm, faster) ###########
eval "$(fnm env --use-on-cd)"
# _evalcache fnm env --use-on-cd





########## add go/bin into path
export PATH=$PATH:/Users/re4388/go/bin




############## kubectl ########
# https://kubernetes.io/zh-cn/docs/reference/kubectl/
## 少用，先關掉
## 如果會常用 這些 k8s cli, 再開
# 載入自動補全
# if [ $commands[kubectl] ]; then source <(kubectl completion zsh); fi




# zsh-autosuggestions
# 目前用 default 就是 ->
# bindkey '^[i' autosuggest-accept
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
# export PATH="$PATH:/Users/re4388/.kit/bin"



# https://github.com/superbrothers/zsh-kubectl-prompt
# display current k8s context
RPROMPT='%{$fg[blue]%}($ZSH_KUBECTL_PROMPT)%{$reset_color%}'

# bindkey '\t' menu-select "$terminfo[kcbt]" menu-select
# bindkey -M menuselect '\t' menu-complete "$terminfo[kcbt]" reverse-menu-complete
# bindkey '\t'  autosuggest-accept
# bindkey '\t' menu-complete

# [ -f ~/.inshellisense/key-bindings.zsh ] && source ~/.inshellisense/key-bindings.zshexport


# psql
PATH="/opt/homebrew/opt/libpq/bin:$PATH"


################### atuin (history with sqlite!) #############
# https://atuin.sh/docs/key-binding#disable-up-arrow
# Bind up-arrow but not ctrl-r
# eval "$(atuin init zsh --disable-ctrl-r)"
_evalcache atuin init zsh --disable-ctrl-r




############## zoxin ###############
# eval "$(zoxide init zsh)"
_evalcache zoxide init zsh



# bun completions
[ -s "/Users/re4388/.bun/_bun" ] && source "/Users/re4388/.bun/_bun"


################### custom commands
source /Users/re4388/project/personal/my-github-pjt/dotfiles/zsh/my_custom_command.zsh



#########  profile code at bottom ###########
######### ref: https://blog.skk.moe/post/make-oh-my-zsh-fly/

# unsetopt XTRACE
# exec 2>&3 3>&-


######## sensitive env variables #########
source /Users/re4388/project/personal/my-github-pjt/dotfiles/zsh/.env


source /Users/re4388/project/personal/zsh_plugin_manual/enhancd/init.sh








########################################################################
########################################################################
########################################################################
############ archived ################
########################################################################
########################################################################
########################################################################







####### pyenv ###############
# by default, "pyenv" and "brew" conflict on how they use PATH
# this alias will ensure brew work correctly

# alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew'
# export PYENV_ROOT="$HOME/.pyenv"
# command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init -)"




##################### pipx  ###################

### note: 影響 cold start, 先關掉，有常用再開

# autoload -U bashcompinit
# bashcompinit
# eval "$(register-python-argcomplete pipx)"

#################### br (replace tree)
# source /Users/re4388/.config/broot/launcher/bash/br



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


# The add-zsh-hook function is part of Zsh and is used for adding hooks, which are functions that get executed at certain points in the Zsh execution cycle. Hooks are useful for performing actions or customizations before or after specific events, such as before a command is executed or after a command is completed.
# autoload -U add-zsh-hook



