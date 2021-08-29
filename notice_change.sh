#!/bin/bash

File=tmp
local_dotfiles_path=~/projects/dotfiles
swift_user_name=re438
asus_user_name=re438
wits_user_name=tp2011002
local_dotfiles_path=~/projects/dotfiles

function git_pull(){
    cd ${local_dotfiles_path} && git pull && cd -
}

function open_lazygit(){
    cd ${local_dotfiles_path} && lazygit
}

function update_ahk(){
    confirm_before_overwrite_local
		cp ${local_dotfiles_path}/autohotkey/ben.ahk /mnt/c/ahk/ben.ahk
}


function bk_wsl_vim(){
    cp -rf ~/.config/nvim ${local_dotfiles_path}/nvim-ver/wsl/vim-IDE-ver/
}

function update_win10_vim(){ 
    confirm_before_overwrite_local
    cp ${local_dotfiles_path}/nvim-ver/win10/vscode-nvim/init.vim /mnt/c/Users/${1}/AppData/Local/nvim/
}

function update_wsl_vim(){
    confirm_before_overwrite_local
    cp -rf ${local_dotfiles_path}/nvim-ver/wsl/vim-IDE-ver/nvim ~/.config/
}

function bk_win10_vim(){
    check_if_machine_correct ${1} 
    cp "/mnt/c/Users/${1}/AppData/Local/nvim/init.vim" "${local_dotfiles_path}/nvim-ver/win10/vscode-nvim/"
}

function updateQuteBrowser(){
    check_if_machine_correct ${1} 
    confirm_before_overwrite_local
    cp "${local_dotfiles_path}/quteBrowser/config.py" "/mnt/c/Users/${1}/AppData/Roaming/qutebrowser/config/config.py"
    cp "${local_dotfiles_path}/quteBrowser/quickmarks" "/mnt/c/Users/${1}/AppData/Roaming/qutebrowser/config/quickmarks"
    # note: when use cp -rf, it copy over the "js" folder into taget path, so the target path shall be at the parent path 
    cp -rf "${local_dotfiles_path}/quteBrowser/js" "/mnt/c/Users/${1}/AppData/Roaming/qutebrowser/config"
    cp -rf "${local_dotfiles_path}/quteBrowser/greasemonkey" "/mnt/c/Users/${1}/AppData/Roaming/qutebrowser/config"
    cp -rf "${local_dotfiles_path}/quteBrowser/userscripts" "/mnt/c/Users/${1}/AppData/Roaming/qutebrowser/config"
}

function bkQuteBrowser(){
    check_if_machine_correct ${1} 
    sudo cp "/mnt/c/Users/${1}/AppData/Roaming/qutebrowser/config/config.py" "${local_dotfiles_path}/quteBrowser"
    sudo cp "/mnt/c/Users/${1}/AppData/Roaming/qutebrowser/config/quickmarks" "${local_dotfiles_path}/quteBrowser"
    # note: when use cp -rf, it copy over the "js" folder into taget path, so the target path shall be at the parent path 
    sudo cp -rf "/mnt/c/Users/${1}/AppData/Roaming/qutebrowser/config/js" "${local_dotfiles_path}/quteBrowser"
    sudo cp -rf "/mnt/c/Users/${1}/AppData/Roaming/qutebrowser/config/greasemonkey" "${local_dotfiles_path}/quteBrowser"
    sudo cp -rf "/mnt/c/Users/${1}/AppData/Roaming/qutebrowser/config/userscripts" "${local_dotfiles_path}/quteBrowser"

}

function bk_ahk(){
    sudo cp "/mnt/c/ahk/ben.ahk" "${local_dotfiles_path}/autohotkey/"
}

# below 3 lines is to get the win10 user name,
# you need to in win10, cmd.exe run: setx WSLENV USERPROFILE/up to make wsl see $USERPROFILE
shopt -s lastpipe
echo $USERPROFILE | awk -F'/' '{print $5}' | read current_machine_usr_name
echo $current_machine_usr_name



cd ${local_dotfiles_path} 1>/dev/null
git fetch
git diff ...origin/main > $File

# cat $File

if grep -q @@ "$File"; then
  echo 'Dotfiles have changes! Do you want to update from dotfiles?'
  read -p "Update? this will overwrite the current files! (y/n)? " answer
  case ${answer:0:1} in
    y|Y )
        echo Continue...
        if [ "$current_machine_usr_name" = "${swift_user_name}" ]; then
          git_pull
          update_ahk
          updateQuteBrowser $swift_user_name
          update_win10_vim $swift_user_name
        else
          echo 'no implement now'
        fi
    ;;
    * )
        echo No Op!
        exit 1
        echo 'no update for this time, quit...'
    ;;
  esac
fi

rm ${File}
