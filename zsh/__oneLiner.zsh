function lsf(){
  ls -al | fzf
}
function llf(){
  ls -al | fzf
}

function brewf(){
  brew ls | fzf
}


########################

function sz(){
  source ~/.zshrc
}


function fullpath() {
  readlink -f $1
}



function repo_summary() {
    onefetch
}

