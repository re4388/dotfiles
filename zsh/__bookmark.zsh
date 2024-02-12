bookmarkRepoPath="/Users/re4388/project/work/bookmark/marks/"

# cm -add
function bookmark_add(){
    # return if the number of arguments is not equal to 1
    if [ "$#" -ne 1 ]; then
        echo "Usage: $0 <filename/bookmark name>"
        return
    fi

    local filename="$1"
    nvim "$bookmarkRepoPath$filename"
}



# cm as code marker
function bookmark() {
    local command=$(ls $bookmarkRepoPath | fzf \
    --height=60% \
    --layout=reverse \
    --border sharp \
    --prompt '∷ ' \
    --pointer "▶" \
    --marker "⇒" \
    --header "Enter to check the code" | awk '{print "$bookmarkRepoPath/"$1}')

    if [ -n "$command" ]; then
     eval "bat $command"
    fi
}

function bookmark_edit() {
    local command=$(ls $bookmarkRepoPath | fzf \
    --height=60% \
    --layout=reverse \
    --border sharp \
    --prompt '∷ ' \
    --pointer "▶" \
    --marker "⇒" \
    --header "Enter to edit the code" | awk '{print "$bookmarkRepoPath/"$1}')

    if [ -n "$command" ]; then
     eval "nvim $command"

    fi
}
