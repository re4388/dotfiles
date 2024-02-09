
snippetRepoPath="/Users/re4388/project/personal/snippet/all"

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

function snippet() {
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
