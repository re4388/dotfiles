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
    command-not-found

    # fzf-tab  # 可以跟 fzf complete use together

    zsh-autocomplete  # 跟 fzf complete 功能衝到
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
export HISTCONTROL=erasedups	# when adding an /item to history, delete itentical commands upstream
export HISTSIZE=10000		# save 10000 items in history







################### fzf ####################
# key bindings:
# CTRL-T - Paste the selected files and directories onto the command-line
# CTRL-R - fzf 版本的 看歷史 -> 目前不需要用，我用 atuin
# ALT-C - fzf 版本的 CD

# 換成更高效的查詢引擎
# export FZF_DEFAULT_COMMAND='rg --files --hidden'
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'


# export FZF_CTRL_T_COMMAND	按鍵對映行為設定
# export FZF_ALT_C_COMMAND	按鍵對映行為設定
# export FZF_CTRL_R_COMMAND	按鍵對映行為設定
export FZF_DEFAULT_OPTS="--inline-info"
# export FZF_DEFAULT_OPTS="--layout=reverse --inline-info"

# export FZF_COMPLETION_DIR_COMMANDS="cd pushd rmdir tree"
# export FZF_COMPLETION_TRIGGER="**"
export FZF_ALT_C_OPTS="--height 60% \
--layout=reverse
--border sharp \
--prompt '∷ ' \
--pointer ▶ \
--marker ⇒"

export FZF_CTRL_T_OPTS="--height 60% \
--layout=reverse
--border sharp \
--prompt '∷ ' \
--pointer ▶ \
--marker ⇒"
export FZF_CTRL_R_OPTS="--height 60% \
--layout=reverse
--border sharp \
--prompt '∷ ' \
--pointer ▶ \
--marker ⇒"


### preview example
# fzf --preview 'cat {}' # 預覽檔案內容
# fzf --preview 'rg -F "def main(" -C 3 {}' # 預覽 Python 檔案 main 函式前後3行程式碼

# fzf --preview '[[ $(file --mime {}) =~ binary ]] &&                                                                                                             (prod/default)
#                  echo {} is a binary file ||
#                  (bat --style=numbers --color=always {} ||
#                   highlight -O ansi -l {} ||
#                   coderay {} ||
#                   rougify {} ||
#                   cat {}) 2> /dev/null | head -500'


# fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'








# key bindings and fuzzy completion
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh





# 目前 fzf 的 completion 跟 zsh-autocomplete 衝到, 因此不起作用
# 我用 zsh-autocomplete, 因為後者的功能比較全面

# fuzzy completion:
# vi ~~<TAB>
# kill -9
# export ~~
# unset	~~

# Use ~~ as the trigger sequence instead of the default **
export FZF_COMPLETION_TRIGGER='~~'

# Options to fzf command
export FZF_COMPLETION_OPTS='--border --info=inline'

# export FZF_COMPLETION_DIR_COMMANDS="cd pushd rmdir tree"

#  to specify shell commands that should be used by fzf (Fuzzy Finder) for directory completion
# export FZF_COMPLETION_DIR_COMMANDS="fd --type d"

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1 # first argument
  shift # shifts the argument list to the left, effectively removing the first argument. The remaining arguments are stored in "$@".

  case "$command" in
    cd)           fzf --preview 'tree -C {} | head -200'   "$@" ;;
    export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview 'bat -n --color=always {}' "$@" ;;
  esac
}


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


###################custom alias
source /Users/re4388/project/personal/my-github-pjt/dotfiles/zsh/__alias.zsh

################### custom commands
source /Users/re4388/project/personal/my-github-pjt/dotfiles/zsh/__bashFn.zsh
source /Users/re4388/project/personal/my-github-pjt/dotfiles/zsh/__oneLiner.zsh

######## sensitive env variables #########
source /Users/re4388/project/personal/my-github-pjt/dotfiles/zsh/.env

########## 一些個人小工作
source /Users/re4388/project/personal/my-github-pjt/dotfiles/zsh/__bookmark.zsh
source /Users/re4388/project/personal/my-github-pjt/dotfiles/zsh/__snippet.zsh


# I install nvim in my own place
# export EDITOR=/Users/re4388/project/personal/nvim-macos/bin/nvim
# export VISUAL=/Users/re4388/project/personal/nvim-macos/bin/nvim
export EDITOR=nvim
export VISUAL=nvim

################# howdoi

alias h='function hdi(){ howdoi $* -c -n 5; }; hdi'


export HOWDOI_COLORIZE=1
export HOWDOI_SEARCH_ENGINE=google




#########  profile code at bottom ###########
######### ref: https://blog.skk.moe/post/make-oh-my-zsh-fly/

# unsetopt XTRACE
# exec 2>&3 3>&-




