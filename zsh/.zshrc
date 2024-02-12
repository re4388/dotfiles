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
    zsh-better-npm-completion

    # here I use the forked version, which can copy to system clipbord https://github.com/brorbw/zsh-vi-mode/tree/master
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

    # if you run a program which is not installed, it will help you to let you know
    # you need to install
    command-not-found

    fzf-tab  # 可以跟 fzf complete use together

    # 自動把 auto complete 的東西顯示出來，no need to tab
    # 但是感覺會有點不直覺，因為 tab 會失效
#     zsh-autocomplete  # 跟 fzf complete 功能衝到

    zsh-autosuggestions
    zsh-syntax-highlighting
)

# 自己管理 repo
source /Users/re4388/project/personal/zsh_plugin_manual/zsh-autopair/zsh-autopair.plugin.zsh
autopair-init


# zsh-completions/src
# 這邊又加入很多 command 的 completion script
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

############# oh-my-zsh #############
export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh



##################### zsh complete 相關 #################
#  test my completion code, so enable it!
# autoload -uz compinit && compinit

# case-insensitive (all), partial-word and then substring completion
# zstyle ':completion:*' matcher-list 'm:{a-za-z}={a-za-z}' \
#     'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
# zstyle ':completion:*' menu yes select

# if type brew &>/dev/null; then
#   fpath=$(brew --prefix)/share/zsh/site-functions:$fpath
#
#   autoload -uz compinit
#   compinit
# fi

############ zsh completion #############
# https://thevaluable.dev/zsh-completion-guide-examples

# 使用上面的 zshfl 取代
# autoload -U compinit && compinit
# fpath=($ZSH/custom/completions $fpath)



######## general setup ##########
# fix tmux on vim color schem
export TERM=xterm-256color
export HISTCONTROL=erasedups	# when adding an /item to history, delete itentical commands upstream
export HISTSIZE=10000		# save 10000 items in history





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
# use alt+ i
bindkey '^[i' autosuggest-accept
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

# I install nvim in my own place
# export EDITOR=/Users/re4388/project/personal/nvim-macos/bin/nvim
# export VISUAL=/Users/re4388/project/personal/nvim-macos/bin/nvim
export EDITOR=nvim
export VISUAL=nvim




################# howdoi

## this is basically use google and search stackoverflow
# alias h='function hdi(){ howdoi $* -c -n 5; }; hdi'
#
# export HOWDOI_COLORIZE=1
# export HOWDOI_SEARCH_ENGINE=google


###################### fff

# leave also cd in the current checking directory
f() {
    fff "$@"
    cd "$(cat "${XDG_CACHE_HOME:=${HOME}/.cache}/fff/.fff_d")"
}

# Show/Hide hidden files on open.
export FFF_HIDDEN=1

# Enable or disable CD on exit.
# (On by default)
export FFF_CD_ON_EXIT=1

# export FFF_TRASH=~/.local/share/fff/trash
export FFF_TRASH=~/.Trash

# Favourites (Bookmarks) (keys 1-9) (dir or file)
export FFF_FAV1=/Users/re4388
export FFF_FAV2=/Users/re4388/project/work
export FFF_FAV3=/Users/re4388/project/personal
export FFF_FAV4=/Users/re4388/Downloads
export FFF_FAV5=/Users/re4388/.config
export FFF_FAV6=/Users/re4388/.oh-my-zsh
export FFF_FAV7=
export FFF_FAV8=
export FFF_FAV9=

################### custom alias
source /Users/re4388/project/personal/my-github-pjt/dotfiles/zsh/__alias.zsh

################### custom commands
source /Users/re4388/project/personal/my-github-pjt/dotfiles/zsh/__bashFn.zsh
source /Users/re4388/project/personal/my-github-pjt/dotfiles/zsh/__oneLiner.zsh

######## sensitive env variables #########
source /Users/re4388/project/personal/my-github-pjt/dotfiles/zsh/.env

########## 套件分開整理
source /Users/re4388/project/personal/my-github-pjt/dotfiles/zsh/__bookmark.zsh
source /Users/re4388/project/personal/my-github-pjt/dotfiles/zsh/__snippet.zsh
source /Users/re4388/project/personal/my-github-pjt/dotfiles/zsh/__shell_gpt_util.zsh
source /Users/re4388/project/personal/my-github-pjt/dotfiles/zsh/__llm_utl.zsh
source /Users/re4388/project/personal/my-github-pjt/dotfiles/zsh/__play.zsh
source /Users/re4388/project/personal/my-github-pjt/dotfiles/zsh/pet.zsh
source /Users/re4388/project/personal/my-github-pjt/dotfiles/zsh/__fzf.zsh


#########  profile code at bottom ###########
######### ref: https://blog.skk.moe/post/make-oh-my-zsh-fly/

# unsetopt XTRACE
# exec 2>&3 3>&-