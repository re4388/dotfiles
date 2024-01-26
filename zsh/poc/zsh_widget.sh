# git pull (ctrl-g+p)
function gitpull() {
    echo "git pull";
    git pull;
    zle reset-prompt;
    zle redisplay
}
zle -N gitpull
bindkey '^gp' gitpull


# create a feature branch with <name> and then ctrl-g+f
function git_feat_branch() {
    branch_name=$BUFFER
    zle backward-kill-line  # delete text from the cursor position to the beginning of the line
    echo "git checkout -b feat/$branch_name"
    git checkout -b "feat/${branch_name}"
    zle reset-prompt
    zle redisplay
}
zle -N git_feat_branch
bindkey '^gf' git_feat_branch
