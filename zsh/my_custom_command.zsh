

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
  # ls -al | fzf --layout reverse
  ls -al | fzf
}
function llf(){
  ls -al | fzf
}


function brewls(){
  brew ls | fzf
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
    --header "Enter to 'bun run <script>'" | awk '{print "/Users/re4388/project/personal/lang/bun/bun_cli_0/scripts/"$1}')

    if [ -n "$command" ]; then
     eval "bun run $command"
    fi
}

# cm -add
function bookmark_add(){
    # Check if the correct number of arguments is provided
    if [ "$#" -ne 1 ]; then
        echo "Usage: $0 <filename/bookmark name>"
        return
    fi

    local filename="$1"

    local path="/Users/re4388/project/work/cm/marks/$filename"
    nvim $path
}



# cm as code marker
function bookmark() {
    local command=$(ls /Users/re4388/project/work/cm/marks | fzf \
    --height=60% \
    --layout=reverse \
    --border sharp \
    --prompt '∷ ' \
    --pointer "▶" \
    --marker "⇒" \
    --header "Enter to check the code" | awk '{print "/Users/re4388/project/work/cm/marks/"$1}')

    if [ -n "$command" ]; then
     eval "bat $command"
    fi
}


function whiteSpace_to_underscore(){
    # check the number of command-line arguments passed to the script (denoted by $#)
    # is equal to 1.
    if [ "$#" -ne 1 ]; then
        echo "Usage: $0 <filename>"
        exit 1
    fi

    # Get the input filename
    filename="$1"

    # Replace white spaces with underscores
    new_filename="${filename// /_}"

    # Rename the file
    mv "$filename" "$new_filename"

    echo "File renamed from '$filename' to '$new_filename'"
}



function snippet_add(){
    # Check if the correct number of arguments is provided
    if [ "$#" -ne 1 ]; then
        echo "Usage: $0 <filename/snippet name>"
        return
    fi

    local filename="$1"

    local path="/Users/re4388/project/personal/snippet/all/$filename"
    nvim $path
}



# cm as code marker
function snippet() {
    local command=$(ls /Users/re4388/project/personal/snippet/all | fzf \
    --height=60% \
    --layout=reverse \
    --border sharp \
    --prompt '∷ ' \
    --pointer "▶" \
    --marker "⇒" \
    --header "Enter to check the snippet" | awk '{print "/Users/re4388/project/personal/snippet/all/"$1}')

    if [ -n "$command" ]; then
     eval "bat $command"
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



fullpath() {
  readlink -f $1
}