#!/bin/bash
# set -e

# prerequiste:
# the laptop need to have $laptop env ready to use
# for example, in wits laptop, it shall have below line in .zshrc
# ```
# export laptop=wits
# ```


swift_user_name=re438
asus_user_name=re438
wits_user_name=tp2011002
local_dotfiles_path=~/projects/dotfiles

if [ ! -d "${local_dotfiles_path}" ]; then
  echo "Directory ${local_dotfiles_path} DOES NOT exists."
  exit 1
else
  echo "${local_dotfiles_path} exists"
fi


function open_lazygit(){
    cd ${local_dotfiles_path} && lazygit
}

function bk_wsl_vim(){
    cp -rf ~/.config/nvim ${local_dotfiles_path}/nvim-ver/wsl/vim-IDE-ver/
}


function bk_win10_vim(){
    cp "/mnt/c/Users/${1}/AppData/Local/nvim/init.vim" "${local_dotfiles_path}/nvim-ver/win10/vscode-nvim/"
}


function bkQuteBrowser(){
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


# I can run below command to get all extension in txt file. Not use often, just put here for future use when needed, can reconsider to remove
# powershell.exe -File "C:\Users\re438\AppData\scripts\get-vsce-ext-list.ps1" > ~/projects/dotfiles/VSCode/win-vsc-ext.txt
# vscode shall sync itself, so, here is for source control prupose
# vscode setting and key-mapping json:
function bk_vscode_setting(){
    cp /mnt/c/Users/${1}/AppData/Roaming/Code/User/settings.json ~/projects/dotfiles/VSCode/
    cp /mnt/c/Users/${1}/AppData/Roaming/Code/User/keybindings.json ~/projects/dotfiles/VSCode/
    cp /mnt/c/Users/${1}/AppData/scripts/get-vsce-ext-list.ps1 ~/projects/dotfiles/VSCode/
}

function bk_powershell_config(){
    cp /mnt/c/Users/${1}/OneDrive/Documents/WindowsPowerShell/Microsoft.PowerShell_profile.ps1 ~/projects/dotfiles/Microsoft/PowerShell/
}

function bk_wsl_zshrc(){
    cp ~/.zshrc ~/projects/dotfiles/zsh/
}

function bk_win10_git_bash(){
    sudo cp -rf /mnt/c/Users/${1}/bin ~/projects/dotfiles/git_bash/
    cp /mnt/c/Users/${1}/.zshrc ~/projects/dotfiles/git_bash/
    cp /mnt/c/Users/${1}/.bash_profile ~/projects/dotfiles/git_bash/
}

function bk_window_terminal_preview_config(){
    cp /mnt/c/Users/${1}/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json ~/projects/dotfiles/Microsoft/WindowsTerminalPreview/
}

function main(){
    if [ "${laptop}" = "swift" ];then
      echo "no plan to backup from swift laptop for now"

    elif [ "${laptop}" = "asus" ];then
      echo Begin to backup...
      bk_win10_vim $asus_user_name
      bkQuteBrowser $asus_user_name
      bk_win10_git_bash $asus_user_name
      bk_wsl_vim
      bk_ahk

      bk_wsl_zshrc
      bk_vscode_setting $asus_user_name
      bk_powershell_config $asus_user_name
      bk_window_terminal_preview_config $asus_user_name

      open_lazygit

    elif [ "${laptop}" = "wits" ];then
      echo Begin to backup...
      bk_win10_vim $wits_user_name
      bkQuteBrowser $wits_user_name
      bk_win10_git_bash $wits_user_name
      bk_wsl_vim
      bk_ahk
      # !!! Attention!!!
      # the zshrc is still coupleing to computer, so I don't want to sync them automatically
      # For now, I only want to update the zshrc from ASUS to WITS
      # if I want to sync from WITS to ASUS, just manually copy and paste via simplenote or notion
      # bk_wsl_zshrc

      open_lazygit
    else
      echo 'no this laptop or export laptop=<laptop_name>is not set in env'
    fi
}


main





