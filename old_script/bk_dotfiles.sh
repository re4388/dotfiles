#!/bin/bash

swift_user_name=re438
asus_user_name=re438
wits_user_name=tp2011002
local_dotfiles_path=~/projects/dotfiles

if [ ! -d "${local_dotfiles_path}" ]; then
  echo "Directory ${local_dotfiles_path} DOES NOT exists."
  exit 1
else
  echo "conti.."
fi


# below 3 lines is to get the win10 user name,
# you need to in win10, cmd.exe run: setx WSLENV USERPROFILE/up to make wsl see $USERPROFILE
shopt -s lastpipe
echo $USERPROFILE | awk -F'/' '{print $5}' | read current_machine_usr_name
echo $current_machine_usr_name

# https://askubuntu.com/questions/1705/how-can-i-create-a-select-menu-in-a-shell-script
PS3='Please enter your choice: '

options=(
  # "Swift_update_ahk_qB_from_git"
  # "Swift_update_win10Vim_from_git"

  # "WITS_update_ahk_qB_from_git"
  # "WITS_update_both_Vim_from_git"

  "WITS_Bk_ahk_qB_to_git"
  "WITS_Bk_both_Vim_to_git"

  # "ASUS_update_ahk_qB_from_git"
  # "ASUS_update_both_vim_from_git"

  "ASUS_Bk_wsl_vim_to_git"
  "ASUS_Bk_Win10_vim_to_git"
  "ASUS_Bk_ahk_qB_to_git"
  "ASUS_Bk_All_to_git"
  "Quit"
)


function check_if_machine_correct(){
  if [ "$current_machine_usr_name" = "${1}" ]; then
    echo "The machine is match!"
  else
    echo "The machine is NOT match!"
    exit 1
  fi
}


function confirm_before_overwrite_local(){
  read -p "this will overwrite the current machine setting! (y/n)? " answer
  case ${answer:0:1} in
    y|Y )
        echo Continue...
    ;;
    * )
        echo No Op!
        exit 1
        echo 'no show'
    ;;
  esac
}

# function git_pull(){
#     cd ${local_dotfiles_path} && git pull && cd -
# }

function open_lazygit(){
    cd ${local_dotfiles_path} && lazygit
}

# function update_ahk(){
#     confirm_before_overwrite_local
# 		cp ${local_dotfiles_path}/autohotkey/ben.ahk /mnt/c/ahk/ben.ahk
# }


function bk_wsl_vim(){
    cp -rf ~/.config/nvim ${local_dotfiles_path}/nvim-ver/wsl/vim-IDE-ver/
}

# function update_win10_vim(){ 
#     confirm_before_overwrite_local
#     cp ${local_dotfiles_path}/nvim-ver/win10/vscode-nvim/init.vim /mnt/c/Users/${1}/AppData/Local/nvim/
# }

# function update_wsl_vim(){
#     confirm_before_overwrite_local
#     cp -rf ${local_dotfiles_path}/nvim-ver/wsl/vim-IDE-ver/nvim ~/.config/
# }

function bk_win10_vim(){
    check_if_machine_correct ${1} 
    cp "/mnt/c/Users/${1}/AppData/Local/nvim/init.vim" "${local_dotfiles_path}/nvim-ver/win10/vscode-nvim/"
}

# function updateQuteBrowser(){
#     check_if_machine_correct ${1} 
#     confirm_before_overwrite_local
#     cp "${local_dotfiles_path}/quteBrowser/config.py" "/mnt/c/Users/${1}/AppData/Roaming/qutebrowser/config/config.py"
#     cp "${local_dotfiles_path}/quteBrowser/quickmarks" "/mnt/c/Users/${1}/AppData/Roaming/qutebrowser/config/quickmarks"
#     # note: when use cp -rf, it copy over the "js" folder into taget path, so the target path shall be at the parent path 
#     cp -rf "${local_dotfiles_path}/quteBrowser/js" "/mnt/c/Users/${1}/AppData/Roaming/qutebrowser/config"
#     cp -rf "${local_dotfiles_path}/quteBrowser/greasemonkey" "/mnt/c/Users/${1}/AppData/Roaming/qutebrowser/config"
#     cp -rf "${local_dotfiles_path}/quteBrowser/userscripts" "/mnt/c/Users/${1}/AppData/Roaming/qutebrowser/config"
# }

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

select opt in "${options[@]}"
do
    case $opt in
        # "Swift_update_ahk_qB_from_git")
        #     echo "you chose choice $REPLY which is $opt"
        #     git_pull
        #     update_ahk
        #     updateQuteBrowser $swift_user_name
        #     break
        #     ;;
        # "Swift_update_win10Vim_from_git")
        #     echo "you chose choice $REPLY which is $opt"
        #     git_pull
        #     update_win10_vim $swift_user_name
        #     break
        #     ;;
        # "WITS_update_both_Vim_from_git")
        #     echo "you chose choice $REPLY which is $opt"
        #     git_pull
        #     update_win10_vim $wits_user_name
        #     update_wsl_vim
        #     break
        #     ;;
        # "WITS_update_ahk_qB_from_git")
        #   echo "you chose choice $REPLY which is $opt"
        #     git_pull
        #     update_ahk
        #     updateQuteBrowser $wits_user_name
        #     break
        #     ;;
        "WITS_Bk_both_Vim_to_git")
            echo "you chose choice $REPLY which is $opt"
            bk_win10_vim $wits_user_name
            bk_wsl_vim $wits_user_name 
            open_lazygit
            break
            ;;
        "WITS_Bk_ahk_qB_to_git")
            echo "you chose choice $REPLY which is $opt"
            bk_ahk
            bkQuteBrowser $wits_user_name
            open_lazygit
            break
            ;;
        # "ASUS_update_both_vim_from_git")
        #     echo "you chose choice $REPLY which is $opt"
        #     git_pull
        #     update_win10_vim $asus_user_name
        #     update_wsl_vim
        #     break
        #     ;;
        # "ASUS_update_ahk_qB_from_git")
        #     echo "you chose choice $REPLY which is $opt"
        #     git_pull
        #     update_ahk
        #     updateQuteBrowser $asus_user_name
        #     break
        #     ;;
        "ASUS_Bk_wsl_vim_to_git")
            echo "you chose choice $REPLY which is $opt"
            bk_wsl_vim
            open_lazygit
            break
            ;;
        "ASUS_Bk_Win10_vim_to_git")
            echo "you chose choice $REPLY which is $opt"
            bk_win10_vim $asus_user_name
            open_lazygit
            break
            ;;
        "ASUS_Bk_ahk_qB_to_git")
            echo "you chose choice $REPLY which is $opt"
            bk_ahk
            bkQuteBrowser $asus_user_name
            open_lazygit
            break
            ;;
        "ASUS_Bk_All_to_git")
            echo "you chose choice $REPLY which is $opt"
            bk_wsl_vim
            bk_win10_vim $asus_user_name

            # ps1
            cp /mnt/c/Users/re438/OneDrive/Documents/WindowsPowerShell/Microsoft.PowerShell_profile.ps1 ~/projects/dotfiles/Microsoft/PowerShell/

            # zsh
            cp ~/.zshrc ~/projects/dotfiles/zsh/

            # window-terminal
            cp /mnt/c/Users/re438/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json ~/projects/dotfiles/Microsoft/WindowsTerminalPreview/

            bk_ahk
            bkQuteBrowser $asus_user_name

            # vscode setting and key-mapping json: vscode will sync itself, here is for source control prupose
            # powershell.exe -File "C:\Users\re438\AppData\scripts\get-vsce-ext-list.ps1" > ~/projects/dotfiles/VSCode/win-vsc-ext.txt
            cp /mnt/c/Users/re438/AppData/Roaming/Code/User/settings.json ~/projects/dotfiles/VSCode/
            cp /mnt/c/Users/re438/AppData/Roaming/Code/User/keybindings.json ~/projects/dotfiles/VSCode/
            cp /mnt/c/Users/re438/AppData/scripts/get-vsce-ext-list.ps1 ~/projects/dotfiles/VSCode/

            # cd ~/projects/dotfiles && lazygit
            open_lazygit

            break
            ;;
        "Quit")
            echo "Quit"
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done




