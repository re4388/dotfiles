
snippetRepoPath="/Users/re4388/project/personal/snippet/all"

function snippet() {

  # Check if one argument is provided
  if [[ $# -ne 1 ]]; then
    echo "Please provide exactly one argument: -a, -e, or -s."
    return 1
  fi

  # Extract the argument
  action="$1"
  case "$action" in
    -a)
      snippet_add
      ;;
    -e)
      snippet_edit
      ;;
    -s)
      snippet_search
      ;;
    *)
      echo "Invalid argument: '$action'. Please use -a, -e, or -s."
      return 1
      ;;
  esac
}


function snippet_add(){
    # return if the number of arguments is not equal to 1
    if [ "$#" -ne 1 ]; then
        echo "Usage: $0 <filename/snippet name>"
        return
    fi

    local filename="$1"
    nvim "$snippetRepoPath/$filename"
}

function snippet_edit() {
    local command=$(ls $snippetRepoPath | fzf \
    --height=60% \
    --layout=reverse \
    --border sharp \
    --prompt '∷ ' \
    --pointer "▶" \
    --marker "⇒" \
    --header "tip: use 'prefix to filter language" | awk '{print "$snippetRepoPath/"$1}')

    if [ -n "$command" ]; then
     eval "nvim $command"
    fi
}

function snippet_search() {
    local command=$(ls $snippetRepoPath | fzf \
    --height=60% \
    --layout=reverse \
    --border sharp \
    --prompt '∷ ' \
    --pointer "▶" \
    --marker "⇒" \
    --header "tip: use 'prefix to filter language" | awk '{print "$snippetRepoPath/"$1}')

    if [ -n "$command" ]; then
     eval "bat $command"
    fi
}
