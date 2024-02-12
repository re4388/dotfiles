




function show_nameOnly_extOnly_() {
    for FILE in $(ls -1); do
        # :r takes filename and removes extension
        # :e takes extension without filename
        # :l lowercases text
        echo "${FILE}"
        echo "${FILE:r}"
        echo "${FILE:e:l}"


#        mv ${FILE} ${FILE:r}.${FILE:e:l}
    done
}


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




function google(){
    if [ -z "$1" ]; then
        echo "Usage: google <query>"
    else
        query="$1"
        open "https://www.google.com/search?q=$query"
    fi
}


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





################################################################
################################################################
################################################################


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





# 使用 alt+r to reload .zshrc
#sz(){
#  source ~/.zshrc
#  zle redisplay
#}
#zle -N sz
#stty -ixon
#bindkey '^[r' sz
