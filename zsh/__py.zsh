function pyenv_pkg_size(){
  cd /Users/re4388/.pyenv/versions/3.10.6/lib/python3.10 && gdu-go
}

function pyenv_show_folder(){
  cd /Users/re4388/.pyenv/versions
}



function pyEnvInit() {
    # create vurtual env and put config in venv folder
    virtualenv venv

    # activate the env
    source venv/bin/activate

    pip list
}