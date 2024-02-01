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
