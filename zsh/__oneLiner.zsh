function brew_size(){
  cd /opt/homebrew/cellar && gdu-go
}

function mac_top(){
  sudo asitop
}

function man_find() {
    compgen -c | fzf | xargs man
}

function py_pkg_size(){
  cd /Users/re4388/.pyenv/versions/3.10.6/lib/python3.10 && gdu-go
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

