using namespace System.Management.Automation.Host
Add-Type -AssemblyName System.Device #Required to access System.Device.Location namespace
# System.Device.Location.GeoCoordinateWatcher need turn on win10 gps
Set-Alias -Name v -Value nvim
Set-Alias -Name lg -Value lazygit
Function CallV2 {nvim -u C:\Users\re438\AppData\Local\nvim_v2\init.vim}
Set-Alias -Name v2 -Value CallV2
# Set-Alias -Name ll -Value ls | Format-Wide -Column 5
$vp = "C:\Users\re438\AppData\Local\nvim\init.vim"
$ws = "C:\projects\"
# $code = "C:\Users\re438\AppData\Local\vscode_nvim\init.vim"

# Global variable wich varies in different machine
# Need to go to machine to set "user env variable", key is ws, value is like "C:\projects\"
# $workspace = $env:ws
# $workspace = "D:\workspace\"

# $time = (Get-Date).ToString("yyyy_MMdd_HHmm")

function touch {set-content -Path ($args[0]) -Value ($null)}
# Global variable wich shall be the same in different machine
# $dateTimeFormat= "yyyy_MMdd_HHmm"
function lsa
{
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
}


# some old code...I don't want to delete
# because I think I may need to refernece these in the future
# I will delete them if I think they are no value to reference
#############################################################################

# Why this not work?
# function get-update{
#     & $profile
# }


# open 3 biolinical repo and npm install
# function get-web {
#     param($f)
#     git clone https://stash.imgdev.bioclinica.com/scm/vf/view-webapp.git D:\workspace\$f-web-app
#     cd D:\workspace\$f-web-app
#     npm i
# }

# function get-img {
#     param($f)
#     git clone https://stash.imgdev.bioclinica.com/scm/vf/imaging-library.git D:\workspace\$f-img-lib
#     cd D:\workspace\$f-img-lib
#     npm i
# }
# function get-view {
#     param($f)
#     git clone https://stash.imgdev.bioclinica.com/scm/vf/view-service.git D:\workspace\$f-view-service
#     cd D:\workspace\$f-view-service
#     npm i
# }


# interactive promp v1
# function get-interactive {
#     $repo = Read-Host -Prompt 'What repo? web | img-lib | view-service'
#     if ($favColor -eq 'Red') {
#     'My favorite, too!'
#     } else {
#         "Eww..$favColor is not a nice color!"
#     }
#     git clone https://stash.imgdev.bioclinica.com/scm/vf/view-webapp.git D:\workspace\$f-web-app
#     cd D:\workspace\$f-web-app
#     npm i
# }


# git clone repo
# how to use?
# git-clone1 -u http://xxxx.git -f 20210207 -n test1
# function git-clone1 {
#     param($f, $u, $n)
#     git clone $u D:\workspace\$f-$n
#     cd D:\workspace\$f-$n
# }

# git-clone2 -u http://xxxx.git
# function git-clone2{
#     param($u)
#     $time = (Get-Date).ToString("yyyy-MM-dd-HH-mm")
#     $repoName = $u.Split('/')[-1]
#     git clone $u D:\workspace\$time-$repoName
#     cd D:\workspace\$time-$repoName
#     code .
# }


# function get-gps{
#     $GeoWatcher = New-Object System.Device.Location.GeoCoordinateWatcher #Create the required object
#     $GeoWatcher.Start() #Begin resolving current locaton

#     while (($GeoWatcher.Status -ne 'Ready') -and ($GeoWatcher.Permission -ne 'Denied')) {
#         Start-Sleep -Milliseconds 100 #Wait for discovery.
#     }

#     if ($GeoWatcher.Permission -eq 'Denied'){
#         Write-Error 'Access Denied for Location Information'
#     } else {
#         $GeoWatcher.Position.Location | Select Latitude,Longitude #Select the relevent results.
#     }
# }

# function call-api{
#     $api = Read-Host -Prompt 'what is the api?'
#     echo "fetching content for $api..."
#     $json=(curl $api -UserAgent "curl").Content | ConvertFrom-Json
#     echo $json
# }


# function speed-check {
#     Start-Process "chrome.exe" "https://speed.cloudflare.com/"
# }



# function check-dicom-tag {
#     param($p)
#     node "C:/projects/powershell-to-node/getHackerNewsTop.js"

# }

# function get-hn{
#     echo "fetching content for HackerNews..."
#     ""
#     $json=(curl https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty -UserAgent "curl").Content | ConvertFrom-Json
#     $top10 = $json | select -First 10


#     $count = 0
#     Foreach ($i in $top10)
#     {
#     $count = $count + 1

#     $json=(curl https://hacker-news.firebaseio.com/v0/item/$i.json?print=pretty -UserAgent "curl").Content | ConvertFrom-Json
#     $json.title
#     $json.url
#     ""
#     }
# }


# function touch {
#     if((Test-Path -Path ($args[0])) -eq $false)
#     {
#         Set-Content -Path ($args[0]) -Value ($null)
#     } else
#     {
#         (Get-Item ($args[0])).LastWriteTime = Get-Date
#     }
# }


# function run-node-getHackerNewsTop{
#     node "C:/projects/powershell-to-node/getHackerNewsTop.js"
# }


# no need to get-wather if I can just type `g weather` via Wox
# function get-weather{
#     $GeoWatcher = New-Object System.Device.Location.GeoCoordinateWatcher #Create the required object
#     $GeoWatcher.Start() #Begin resolving current locaton

#     while (($GeoWatcher.Status -ne 'Ready') -and ($GeoWatcher.Permission -ne 'Denied')) {
#         Start-Sleep -Milliseconds 100 #Wait for discovery.
#     }

#     if ($GeoWatcher.Permission -eq 'Denied'){
#         Write-Error 'Access Denied for Location Information'
#     }

#     $Latitude = ($GeoWatcher.Position.Location).Latitude
#     $Longitude = ($GeoWatcher.Position.Location).Longitude

#     (curl http://wttr.in/"$Latitude,$Longitude"?lang=zh-tw -UserAgent "curl" ).Content
# }

# quick way to open web-page I want, but it's faster if I use autohotkey?
# function get-info {
#     Start-Process "chrome.exe" "https://www.google.com/maps/dir/709%E5%8F%B0%E5%8D%97%E5%B8%82%E5%AE%89%E5%8D%97%E5%8D%80%E5%AE%89%E4%B8%AD%E8%B7%AF%E4%B8%80%E6%AE%B5705%E5%B7%B7/%E5%8F%B0%E5%8D%97%E5%B8%82%E6%AD%B8%E4%BB%81%E5%8D%80%E6%AD%B8%E4%BB%81%E5%A4%A7%E9%81%93%E5%8F%B0%E5%8D%97%E9%AB%98%E9%90%B5%E7%AB%99/@23.0072324,120.1671219,12z/data=!3m1!4b1!4m14!4m13!1m5!1m1!1s0x346e77a3458f3301:0xa2bf1af311313f6e!2m2!1d120.1948315!2d23.0427458!1m5!1m1!1s0x346e73a601a91ea5:0x23e545d7cc3c9e7!2m2!1d120.285662!2d22.92464!3e0"
# }

