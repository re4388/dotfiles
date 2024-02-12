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