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
export HISTCONTROL=erasedups	# when adding an item to history, delete itentical commands upstream
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
export FZF_DEFAULT_OPTS="--layout=reverse --inline-info"

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
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh





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


###############################################
##################### alias ###################
###############################################



alias vi=lvim
alias vim=lvim
alias nvim=nvim


alias kc=kubectl
alias minik=minikube
alias kctx=kubectx


# IDEA open, like `code` for vscode
alias idea='open -na "IntelliJ IDEA.app" --args'
alias goland='open -na "GoLand.app" --args'
alias du='gdu-go'

alias fdf="fd | fzf"


alias ls="eza"
alias ll="eza"

###############################################
###############################################
###############################################












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





##########################################################
##########################################################
###################### shell script ######################
##########################################################
##########################################################


# fkill - kill processes - list only the ones you can kill. Modified the earlier script.
#killf() {
#    local pid
##    Checks whether the script is running as the root user.
##    If the user is not root, it uses ps to list processes owned by the user with the given UID.
##    If the user is root, it lists all processes using ps -ef.
#    if [ "$UID" != "0" ]; then
#        pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
#    else
#        pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
#    fi
#
## Checks if the pid variable is not empty.
#    if [ "x$pid" != "x" ]
#    then
#        echo $pid | xargs kill -${1:-9}
#    fi
#}



function lsf(){
  ls -al | fzf --layout reverse
}


sz(){
  source ~/.zshrc
}


# 使用 alt+r to reload .zshrc
#sz(){
#  source ~/.zshrc
#  zle redisplay
#}
#zle -N sz
#stty -ixon
#bindkey '^[r' sz


google(){
    if [ -z "$1" ]; then
        echo "Usage: google <query>"
    else
        query="$1"
        open "https://www.google.com/search?q=$query"
    fi
}

##################### pet ##############
# to help me to add a new command to pet
function prev() {
  # retrieving the most recent command from the command history
  PREV=$(fc -lrn | head -n 1)
  # executes a new shell (sh) with a command passed as a string
  # The %q format of printf escapes special characters, ensuring that the command can be safely executed.
  sh -c "pet new `printf %q "$PREV"`"
}


# 熱鍵版本
function pet-select() {
  BUFFER=$(pet search --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle redisplay
}
zle -N pet-select
stty -ixon
bindkey '^[s' pet-select

# 指令版本 -> 還在找方法
#function petf() {
#  BUFFER=$(pet search --query "$LBUFFER")
#  CURSOR=$#BUFFER
#  zle redisplay
#
#  BUFFER=$(pet search --query "$LBUFFER")
#  CURSOR=$#BUFFER
#  zle redisplay
#}
#zle -N petf
#stty -ixon
#bindkey '^[s' petf

##########################################


# 一些指令，可以使用 alt+h triiger hzh 的 help manu
source $HOME/.local/share/fzf-help/fzf-help.zsh
zle -N fzf-help-widget
bindkey "^[h" fzf-help-widget



# V1 可以看到 code 的版本，但其實沒必要 XD
#function _bun_script {
#  local res=$(fd --search-path '/Users/re4388/project/personal/lang/bun/bun_cli_0/scripts' | fzf --preview 'bat -n --color=always {}' | awk '{print "bun /Users/re4388/project/personal/lang/bun/bun_cli_0/scripts/"$1}')
#
#  if [[ -n "$res" ]]; then
#      LBUFFER=$LBUFFER$res
#      zle redisplay
#  fi
#}


# V2 跳出來再自己跑起來的版本
#function _bun_script {
#  local res=$(ls /Users/re4388/project/personal/lang/bun/bun_cli_0/scripts | fzf | awk '{print "bun /Users/re4388/project/personal/lang/bun/bun_cli_0/scripts/"$1}')
#
#  if [[ -n "$res" ]]; then
#      LBUFFER=$LBUFFER$res
#      zle redisplay
#  fi
#}
#zle -N _bun_script        # create a new Zsh widget
#stty -ixon                # send to tty as regular characters
#bindkey "^[e" _bun_script # ctrl+e (同 caps + -> )


# V3 自己跑的版本 -> 自己跑的話，無法用 widget 跑
#function _bun_script2() {
#    local command=$(ls /Users/re4388/project/personal/lang/bun/bun_cli_0/scripts | fzf | awk '{print "bun /Users/re4388/project/personal/lang/bun/bun_cli_0/scripts/"$1}')
#
#    if [ -n "$command" ]; then
#      eval "bun run $command"
#    fi
#}
#zle -N _bun_script2        # create a new Zsh widget
#bindkey "^[e" _bun_script2 # ctrl+e (同 caps + -> )

# V4 自己跑的版本 -> 自己跑的話，無法用 widget 跑
function ben() {
    local command=$(ls /Users/re4388/project/personal/lang/bun/bun_cli_0/scripts | fzf \
    --height=60% \
    --layout=reverse \
    --border sharp \
    --prompt '∷ ' \
    --pointer "▶" \
    --marker "⇒" \
    --header "Enter to 'bun run <script>'" | awk '{print "bun /Users/re4388/project/personal/lang/bun/bun_cli_0/scripts/"$1}')

    if [ -n "$command" ]; then
      eval "bun run $command"
    fi
}






# 跑 npm scripts
####### source: https://github.com/torifat/npms/blob/master/npms.plugin.zsh
function npms() {
  #   check package.json exist and if it does not exist -> echo to stderr
  if [ ! -f package.json ]; then
    echo "package.json not found" >&2
  else

    local command=$(
      jq '.scripts | keys[]' package.json -r | tr -d '"' |
      fzf --reverse \
        --preview-window=:wrap \
        --preview "jq '.scripts.\"{}\"' package.json -r | tr -d '\"' | sed 's/^[[:blank:]]*//'"
      )

    if [ -n "$command" ]; then
      eval "npm run $command"
    fi
  fi
}

##########################################################
##########################################################
##########################################################
##########################################################
##########################################################










#########  profile code at bottom ###########
######### ref: https://blog.skk.moe/post/make-oh-my-zsh-fly/

# unsetopt XTRACE
# exec 2>&3 3>&-


######## sensitive env variables #########
source /Users/re4388/project/personal/my-github-pjt/dotfiles/zsh/.env




