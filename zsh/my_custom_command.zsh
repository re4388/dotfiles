sz(){
  source ~/.zshrc
}


google() {
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
  PREV=$(fc -lrn | head -n 1)
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
    local command=$(ls /Users/re4388/project/personal/lang/bun/bun_cli_0/scripts | fzf | awk '{print "bun /Users/re4388/project/personal/lang/bun/bun_cli_0/scripts/"$1}')

    if [ -n "$command" ]; then
      eval "bun run $command"
    fi
}


############ fzf-help ############

source $HOME/.local/share/fzf-help/fzf-help.zsh
zle -N fzf-help-widget
bindkey "^[h" fzf-help-widget


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


################################ not work yet





################################ work


# We don’t have to bind keystrokes to widgets, however. We can bind them to whole series of keystrokes, as we were typing them in ZLE. To do so, we can use the bindkey’s option -s.
# bindkey -s '^[e' '^l hello' # alt+e


# autoload -Uz incarg
# zle -N incarg
# bindkey -M vicmd '^A' incarg  ## 定義 ctrl+a 在 vicmd mode(vim normal mode) (-M keymap)

#
# bindkey '^[ec' vi-cmd-mode # alt+e, c




# function _git-diff {
#     zle .kill-whole-line  # It will remove the 'git diff'
#     zle -U "git diff      # zle -U, This command inserts some string in ZLE
# $CUTBUFFER"
# }
#
# zle -N _git-diff
# bindkey '^[ec' _git-diff

# PS: The variable $CUTBUFFER contains whatever was deleted
# when using a widget beginning with kill-. It allows us to bring back the command previously deleted with .kill-whole-line.

# Let’s say that you want a widget to prepend “vim” to any command



## another version
#function _git-diff {
#    zle push-input       # It pushes the command on the edit buffer stack
#    BUFFER="git diff"    # We change the current buffer to git diff
#    zle accept-line      # accept-line which runs whatever command written in ZLE buffer and The widget push-input pull back the command from the buffer stack
#}
#
#zle -N _git-diff
#bindkey '^[ee' _git-diff


# a widget to prepend “vim” to any command
#Moves the cursor to the end of the line.
#function _vim {
#    # shellcheck disable=SC2076
#    [[ ! $BUFFER =~ '^vi.*' ]] && BUFFER="vim $BUFFER" && zle end-of-line
#}
#
#zle -N _vim
##bindkey -M vicmd '^[ee' _vim
#bindkey '^[ee' _vim


# run npm script (requires jq)
#fns() {
#  local script
#  script=$(cat package.json | jq -r '.scripts | keys[] ' | sort | fzf) && npm run $(echo "$script")
#}

#fzf_fd_widget() {
#  local selected
#  if selected=$(locate / | fzf -q "$LBUFFER"); then
#    LBUFFER=$selected
#  fi
#  zle redisplay
#}
#zle     -N    fzf_fd_widget
#bindkey '^[i' fzf_fd_widget


