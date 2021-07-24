
using namespace System.Management.Automation.Host
Add-Type -AssemblyName System.Device #Required to access System.Device.Location namespace

Set-Alias -Name v -Value nvim
Set-Alias -Name lg -Value lazygit
Function CallV2 {nvim -u C:\Users\re438\AppData\Local\nvim_v2\init.vim}
Set-Alias -Name v2 -Value CallV2
$vp = "C:\Users\re438\AppData\Local\nvim\init.vim"
$ws = "C:\projects\"

function touch {set-content -Path ($args[0]) -Value ($null)}
# Global variable wich shall be the same in different machine
# $dateTimeFormat= "yyyy_MMdd_HHmm"
function lsa{
    ls | Format-Wide -Column 5
}

# open profile with vscode
function Edit-ProfileFile{
    code $profile
}
Set-Alias open-profile Edit-ProfileFile


function change_repo_acc {
    [CmdletBinding()]

    $show = [ChoiceDescription]::new('&show','show')
    $Bitbucket = [ChoiceDescription]::new('&Bitbucket','Bitbucket')
    $GitHub = [ChoiceDescription]::new('&GitHub','GitHub')
    $abort = [ChoiceDescription]::new('&abort','Abort')

    $options = [ChoiceDescription[]]($show, $Bitbucket, $GitHub, $abort )
    $result = $host.ui.PromptForChoice($Title, $Question, $options, 0)

    switch ($result) {
        0 { show_current_version_control_account }
        1 { switch_to_Bioclical_GitBucket }
        2 { switch_to_GitHub }
        3 { "Do nothing, Abort mission.." }
    }
}

function show_current_version_control_account {
    git config --list --show-origin | rg user.
}

function switch_to_Bioclical_GitBucket {
    git config --global user.name "ben.hu"
    git config --global user.email "ben.hu@bioclinica.com"
    show_current_version_control_account
}

function switch_to_GitHub {
    git config --global user.name "re4388"
    git config --global user.email "re4388@gmail.com"
    show_current_version_control_account
}

# 1. get clond 3 Bioclincal repos and also auto npm install
# 2. also can git clone other repo and you have to provide the repo name
function get-Bioclincal-repos {
    [CmdletBinding()]

    $web = [ChoiceDescription]::new('&web-app','web-app')
    $img = [ChoiceDescription]::new('&img-lib','imging-library')
    $view = [ChoiceDescription]::new('&view','view-service')
    $abort = [ChoiceDescription]::new('&abort','Abort')
    $other = [ChoiceDescription]::new('&other','other')

    $options = [ChoiceDescription[]]($web, $img, $view, $abort, $other )
    $result = $host.ui.PromptForChoice($Title, $Question, $options, 0)

    switch ($result) {
        0 { get_webApp }
        1 { get_imgLib }
        2 { get_viewservice }
        3 { "Do nothing, Abort mission.." }
        4 { get_other_repo }
    }
}

function get_other_repo {
    $url = Read-Host -Prompt 'What is the repo gist?'
    $repoName = $url.Split('/')[-1]
    git clone $url $workspace$time-$repoName
    cd $workspace$time-$repoName
    code .
}

function get_viewservice {
    git clone https://stash.imgdev.bioclinica.com/scm/vf/view-service.git $workspace$time-view-service
    cd $workspace$time-view-service
    npm i
}

function get_imgLib {
    git clone https://stash.imgdev.bioclinica.com/scm/vf/imaging-library.git $workspace$time-img-lib
    cd $workspace$time-img-lib
    npm i
}

function get_webApp {
    git clone https://stash.imgdev.bioclinica.com/scm/vf/view-webapp.git $workspace$time-web-app
    cd $workspace$time-web-app
    npm i
}

Import-Module posh-git
Import-Module oh-my-posh
# ugly..
# Set-PoshPrompt -Theme Darkblood
# no subfolder..
# Set-PoshPrompt -Theme Space
Set-PoshPrompt -Theme Iterm2

# show all self-hand command
function show {
    Write-Output ""
    Write-Output "*****"
    Write-Output "All Custom Utility"
    Write-Output "- Open Profile with Vscode:        open-profile             (ahk:ooo)"
    Write-Output "- Reload config & show:            . `$profile               (ahk:rrr)"
    Write-Output "- Git clone Utility:               get-Bioclincal-repo      (ahk:fff)"
    Write-Output "- Check global npm packages:       npm list -g --depth 0"
    Write-Output "- Change acc b/n GitHub &Bucket:   change_repo_acc"
    Write-Output "- `$vp => neovim init.vim path"
    Write-Output "- `$ws => c:/projects"
    Write-Output "*****"
