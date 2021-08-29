#!/bin/bash

File=tmp
local_dotfiles_path=~/projects/dotfiles
swift_user_name=re438
asus_user_name=re438
wits_user_name=tp2011002
local_dotfiles_path=~/projects/dotfiles

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
