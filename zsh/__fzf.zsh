

################### fzf help ####################


# 把 help 拉出來 fzf
source $HOME/.local/share/fzf-help/fzf-help.zsh
zle -N fzf-help-widget
bindkey "^[h" fzf-help-widget


################### fzf util ####################

# key bindings:
# CTRL-T - Paste the selected files and directories onto the command-line
# CTRL-R - fzf 版本的 看歷史 -> 目前不需要用，我用 atuin
# ALT-C - fzf 版本的 CD

# 換成更高效的查詢引擎
export FZF_DEFAULT_COMMAND='rg --files --hidden'
# export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'


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



################### fzf completion ####################

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

############# fzf-tab ############

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'