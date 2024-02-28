


function jq2() {
    if [[ -z "$1" ]]; then
      echo "Usage: jq2 <jsonFile>"
      exit 1
    fi

    local file="$1"
    echo file
    interactively "jq {} $file"
}

function reminder() {

    # 1. Access the "a/b/c" folder
    cd /Users/re4388/project/personal/lang/bun/bun_cli_0/data/reminder || exit 1  # Exit if the directory doesn't exist

    # Initialize an empty array to store the xxxx parts
    file_list=()

    # Loop through all files in the directory
    for file in *; do
        # Check if the file is a regular file
        if [ -f "$file" ]; then
            # Extract the xxxx part before the underscore
            xxxx=$(echo "$file" | cut -d'_' -f1)
            # Add xxxx part to the list
            file_list+=("$xxxx")
        fi
    done

    # Print the list
    for item in "${file_list[@]}"; do
        echo "$item"
    done

    # langList[@] is shell way to get all ele from a list
    selected_project=$(printf "%s\n" "${file_list[@]}" | fzf)

    # Check if an item was selected
    if [[ -n "$selected_project" ]]; then
      # Do something with the selected item
#      echo "You selected: $selected_project"
      bun run /Users/re4388/project/personal/lang/bun/bun_cli_0/standalone/reminder.ts $selected_project
    else
      echo "No item selected."
    fi


}



# 網路上的成功率還比較高
#function html2pdf() {
#  if [[ -z "$1" ]]; then
#    echo "Usage: html2pdf.sh <url>"
#    exit 1
#  fi
#
#  docker run --rm -v $(pwd):/converted/ arachnysdocker/athenapdf athenapdf "$1"
#}



############ 自動 ls  when change pwd #########
# `emulate -L zsh`` ->
# This command sets the emulation mode for the shell.
# emulate -L zsh instructs the shell to emulate behavior similar to a Zsh shell.
# The -L option ensures that the shell's behavior closely matches that of a login shell.
do-ls() {emulate -L zsh; eza --sort newest -a --hyperlink -l;}

# add do-ls to chpwd hook
add-zsh-hook chpwd do-ls



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

function google(){
    if [ -z "$1" ]; then
        echo "Usage: google <query>"
    else
        query="$1"
        open "https://www.google.com/search?q=$query"
    fi
}


function ben() {
    local command=$(ls /Users/re4388/project/personal/lang/bun/bun_cli_0/scripts | fzf \
    --height=60% \
    --layout=reverse \
    --border sharp \
    --prompt '∷ ' \
    --pointer "▶" \
    --marker "⇒" \
    --header "Enter to 'bun run <script>'" | awk '{print "/Users/re4388/project/personal/lang/bun/bun_cli_0/scripts/"$1}')

    if [[ -n "$command" ]]; then
      # Extract the file extension
      extension="${command##*\.}"

      # Handle different cases based on extension
      case "$extension" in
        # Bun scripts (.js, .ts)
        js|ts)
          eval "bun run $command"
          ;;
        # Shell scripts (.sh, .zsh)
        sh|zsh)
          bash "$command"
          ;;
        # Executables
        *)
          if [[ -x "$command" ]]; then
            "$command"
          else
            echo "$command is not executable!"
          fi
          ;;
      esac
    fi
}


function whiteSpace_to_underscore_of_rename(){
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
