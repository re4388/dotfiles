using namespace System.Management.Automation.Host

Add-Type -AssemblyName System.Device #Required to access System.Device.Location namespace

Set-Alias -Name v -Value nvim
Set-Alias -Name lg -Value lazygit

$time = (Get-Date).ToString("yyyy_MMdd_HHmm")

## tip: get all env in powershell: `Get-ChildItem env:`
$vp = "${env:userprofile}\AppData\Local\nvim\init.vim"
$workspace = "C:\link\ws\"

function touch {
    set-content -Path ($args[0]) -Value ($null)
}

function lsa {
    ls | Format-Wide -Column 5
}

function Edit-ProfileFile {
    code $profile
}

Set-Alias open-profile Edit-ProfileFile


function change_repo_acc {
    [CmdletBinding()]

    $op_1 = [ChoiceDescription]::new('&show', 'show')
    $op_2 = [ChoiceDescription]::new('&Bitbucket', 'Bitbucket')
    $op_3 = [ChoiceDescription]::new('&GitHub', 'GitHub')
    $op_4 = [ChoiceDescription]::new('&ERT_GitLab', 'GitLab')
    $op_5 = [ChoiceDescription]::new('&quit', 'Quit')

    $options = [ChoiceDescription[]]($op_1, $op_2, $op_3, $op_4, $op_5 )
    $result = $host.ui.PromptForChoice($Title, $Question, $options, 0)

    switch ($result) {
        0 { show_current_version_control_account }
        1 { switch_to_Bioclical_GitBucket }
        2 { switch_to_GitHub }
        3 { switch_to_GitLab }
        4 { "Quit" }
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

function switch_to_GitLab {
    git config --global user.name "ben.hu"
    git config --global user.email "ben.hu@ert.com"
    show_current_version_control_account
}

# 1. get clond 3 Bioclincal repos and also auto npm install
# 2. also can git clone other repo and you have to provide the repo name
function get-Bioclincal-repos {
    [CmdletBinding()]

    $web = [ChoiceDescription]::new('&web-app', 'web-app')
    $img = [ChoiceDescription]::new('&img-lib', 'imging-library')
    $view = [ChoiceDescription]::new('&view', 'view-service')
    $quit = [ChoiceDescription]::new('&quit', 'quit')
    $other = [ChoiceDescription]::new('&other', 'other')

    $options = [ChoiceDescription[]]($web, $img, $view, $quit, $other )
    $result = $host.ui.PromptForChoice($Title, $Question, $options, 0)

    switch ($result) {
        0 { get_webApp }
        1 { get_imgLib }
        2 { get_viewservice }
        3 { "Quit Successfully" }
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
    # cd can also be replaced with Set-Location
    # this is where the wingle underscore comes from
    cd $workspace$time-web-app
    npm i
}

Import-Module posh-git
Import-Module oh-my-posh
# ugly..
# Set-PoshPrompt -Theme Darkblood
# no subfolder..
# Set-PoshPrompt -Theme Space
# Set-PoshPrompt -Theme Iterm2
# Set-PoshPrompt -Theme ys
# Set-PoshPrompt -Theme jonnychipz
Set-PoshPrompt -Theme microverse-power

# add zoxide
# Invoke-Expression (& {
#     $hook = if ($PSVersionTable.PSVersion.Major -lt 6) { 'prompt' } else { 'pwd' }
#     (zoxide init --cmd j --hook $hook powershell) -join "`n"
# })
# Shows navigable menu of all options when hitting Tab
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
# Autocompletion for arrow keys
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward


# auto-suggestion
Import-Module PSReadLine
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineKeyHandler -Key "Ctrl+j" -Function ForwardWord
# alow Ctrl + A, Ctrl -E, Ctrl -P, Ctrl-N work well as linux
Set-PSReadLineOption -EditMode Emacs



function run_git_bash {
    Write-Output 'still trying'
    # "C:\Program Files\Git\bin\sh.exe" -l  "/C/Users/${env:USERNAME}/bin/git_clone_repo.sh"
    # cmd /c '"C:\Program Files\Git\bin\sh.exe" --login' "./bin/git_clone_repo.sh"
}

# show all self-hand command
function show {
    Write-Output ""
    Write-Output " == Utility == "
    Write-Output ""
    Write-Output "- Open Profile with Vscode:        open-profile             (ahk:ooo)"
    Write-Output "- Reload config & show:            . `$profile               (ahk:rrr)"
    Write-Output ""
    Write-Output " == Scripts == "
    Write-Output ""
    Write-Output "- get-Bioclincal-repo:                                      (ahk:fff)"
    Write-Output "- Show Jira related ticket:                                 (ahk:jjj)"
    Write-Output "- Change acc b/n GitHub &Bucket:   change_repo_acc"
    Write-Output "- Check global npm packages:       npm list -g --depth 0"
    Write-Output "- `$vp                              neovim init.vim path"
    Write-Output "- `$ws                              c:/projects"
    Write-Output ""
    Write-Output " == git alias =="
    Write-Output ""
    Write-Output "git cn    = git commit --no-verify -m"
    Write-Output "git a     = git add ."
    Write-Output "git s     = git status"
    Write-Output "git undo  = git reset --soft head^"
    Write-Output "*****"
}


