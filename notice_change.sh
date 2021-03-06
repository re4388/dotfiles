#!/bin/bash

File=tmp
swift_user_name=re438
asus_user_name=re438
wits_user_name=tp2011002
local_dotfiles_path=~/projects/dotfiles
current_laptop=$laptop


function git_pull(){
    cd ${local_dotfiles_path} && git pull && cd -
}


function update_ahk(){
		cp ${local_dotfiles_path}/autohotkey/ben.ahk /mnt/c/ahk/ben.ahk
}



function update_win10_vim(){ 
    cp ${local_dotfiles_path}/nvim-ver/win10/vscode-nvim/init.vim /mnt/c/Users/${1}/AppData/Local/nvim/
}

function update_wsl_vim(){
    cp -rf ${local_dotfiles_path}/nvim-ver/wsl/vim-IDE-ver/nvim ~/.config/
}


function updateQuteBrowser(){
    cp "${local_dotfiles_path}/quteBrowser/config.py" "/mnt/c/Users/${1}/AppData/Roaming/qutebrowser/config/config.py"
    cp "${local_dotfiles_path}/quteBrowser/quickmarks" "/mnt/c/Users/${1}/AppData/Roaming/qutebrowser/config/quickmarks"
    # note: when use cp -rf, it copy over the "js" folder into taget path, so the target path shall be at the parent path 
    cp -rf "${local_dotfiles_path}/quteBrowser/js" "/mnt/c/Users/${1}/AppData/Roaming/qutebrowser/config"
    cp -rf "${local_dotfiles_path}/quteBrowser/greasemonkey" "/mnt/c/Users/${1}/AppData/Roaming/qutebrowser/config"
    cp -rf "${local_dotfiles_path}/quteBrowser/userscripts" "/mnt/c/Users/${1}/AppData/Roaming/qutebrowser/config"
}




# no need to display ls result after cd, so here we use 1>/dev/null to not display it 
cd ${local_dotfiles_path} 1>/dev/null
git fetch
git diff ...origin/main > $File

# cat $File

if grep -q @@ "$File"; then
  echo ''
  echo ''
  echo 'Dotfiles have changes! Do you want to update from dotfiles?'
  read -p "Update? this will overwrite the current files! (y/n)? " answer
  case ${answer:0:1} in
    y|Y )
        echo Begin to check laptop...
        if [ "${laptop}" = "swift" ]; then
          echo Begin to update...
          git_pull
          update_ahk
          updateQuteBrowser $swift_user_name
          update_win10_vim $swift_user_name
          update_wsl_vim
          echo update complete!
        elif [ "${laptop}" = "asus" ];then
          echo Begin to update...
          git_pull
          update_ahk
          updateQuteBrowser $asus_user_name
          update_win10_vim $asus_user_name
          update_wsl_vim
          echo update complete!
        elif [ "${laptop}" = "wits" ];then
          echo Begin to update...
          git_pull
          update_ahk
          updateQuteBrowser $wits_user_name
          update_win10_vim $wits_user_name
          update_wsl_vim
          echo update complete!
        else
          echo 'not implement yet'
        fi
    ;;
    * )
        echo 'No update for this time, quit...'
    ;;
  esac
fi

rm ${File}
