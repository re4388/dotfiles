autoload -U edit-command-line
zle -N edit-command-line
#bindkey -M vicmd v edit-command-line
#bindkey -M emacs "^e^v" edit-command-line
bindkey '^e' edit-command-line


# 當你編輯一個 long command, 如果臨時需要先打其他的 command check, 可以先 ^q
# 會把目前 input push 到 input stack
# 你 push input 的 long command will pop up after your run one command
bindkey '^q' push-input

function prepend-sudo {
  if [[ $BUFFER != "sudo "* ]]; then
    BUFFER="sudo $BUFFER"; CURSOR+=5
  fi
}
zle -N prepend-sudo
#bindkey -M vicmd s prepend-sudo


zmodload -i zsh/parameter

# use alt + p to paste last command output
insert-last-command-output() {
  LBUFFER+="$(eval $history[$((HISTCMD-1))])"
}
zle -N insert-last-command-output
bindkey -M emacs "^[p" insert-last-command-output
