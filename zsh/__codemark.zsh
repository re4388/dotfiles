codemarkRepoPath="/Users/re4388/project/work/codemark/marks/"

function codemark() {

  # Check if one argument is provided
  if [[ $# -ne 1 ]]; then
    echo "Please provide exactly one argument: -a, -e, or -s."
    return 1
  fi

  # Extract the argument
  action="$1"
  case "$action" in
    -a)
      codemark_add
      ;;
    -e)
      codemark_edit
      ;;
    -s)
      codemark_search
      ;;
    *)
      echo "Invalid argument: '$action'. Please use -a, -e, or -s."
      return 1
      ;;
  esac
}


function codemark_add(){
    # return if the number of arguments is not equal to 1
    if [ "$#" -ne 1 ]; then
        echo "Usage: $0 <filename as codemark_title>"
        return
    fi

    local filename="$1"
    nvim "$codemarkRepoPath$filename"
}



# cm as code marker
function codemark_search() {
    local command=$(ls $codemarkRepoPath | fzf \
    --height=60% \
    --layout=reverse \
    --border sharp \
    --prompt '∷ ' \
    --pointer "▶" \
    --marker "⇒" \
    --header "Enter to check the code" | awk '{print "$codemarkRepoPath/"$1}')

    if [ -n "$command" ]; then
     eval "bat $command"
    fi
}

function codemark_edit() {
    local command=$(ls $codemarkRepoPath | fzf \
    --height=60% \
    --layout=reverse \
    --border sharp \
    --prompt '∷ ' \
    --pointer "▶" \
    --marker "⇒" \
    --header "Enter to edit the code" | awk '{print "$codemarkRepoPath/"$1}')

    if [ -n "$command" ]; then
     eval "nvim $command"

    fi
}
