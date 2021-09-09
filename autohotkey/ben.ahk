; Note on comment shortcut
;  +  shift
;  !  alt
;  ^  ctrl
;  #  window key

; Retrieves an environment variable and stores its value in OutputVar.
; EnvGet, OutputVar, username

^+z::
  msgBox, hello world %computername%-%username%
  return

^+r:: ; press control+r to reload
  Msgbox, Do you want to reload this script?
  ifMsgBox, Yes
    sleep 100
    reload, C:\ahk\ben.ahk ; require all pc put config in below link and the same name, ben.ahk
  return


; Alt & 1 => use in vscode which key activation
; Alt & 2 => vscode:toggle vscode terminal
; Alt & 3 => vscode:toggle Jopline sidebar
Alt & 4::!F4 ; close win10 window, alt+f4
Alt & 5::WinMaximize, A


^+b:: ; press control+r to reload
  SendMode Input
  Run, ms-settings:bluetooth
  return


; Msgbox, %A_ComputerName%

; Note:
; I would like try to use ctrl+shift+key for autohotkey global hotkey..
; this is not a easy reach to type in coding since far from home-row
; so I probably not use this Combo when coding, so might a good idea to use this for global key like autohotkey

; letter I had use for ctrl+shift Combo
; z,debug
; a, autohotkey file opened in vscode
; g, google in highlighted/text in clipboard
; n, opne tmp.txt
; j, no use, reverse to tab switch for window terminal preview
; k, same as above


^+a::
  ; Run, %vscode_path %autoHotkey_Path
  Run, "C:\Users\%A_UserName%\AppData\Local\Programs\Microsoft VS Code\Code.exe" "C:\ahk\ben.ahk"
  ; return is required for multi-line commmand
  return

; ASUS
if (A_ComputerName  = "LAPTOP-UO6DJS4G") {
  OneDriveTmpNotepad_path = "C:\Users\%A_UserName%\OneDrive - g.ntu.edu.tw\notepad-backup\tmp.txt"
}


; WITS
if (A_ComputerName  = "XXXXXXXXX") {
  ; autoHotkey_Path = "C:\ahk\ben.ahk"
  ; vscode_path = "C:\Users\re438\AppData\Local\Programs\Microsoft VS Code\Code.exe"
  OneDriveTmpNotepad_path = "C:\Users\re438\OneDrive - g.ntu.edu.tw\notepad-backup\tmp.txt"
}


; Swift
if (A_ComputerName  = "LAPTOP-Q5UL0L1G") {
  OneDriveTmpNotepad_path = "C:\Users\%A_UserName%\OneDrive - g.ntu.edu.tw\notepad-backup\tmp.txt"
  ; OneDriveTmpNotepad_fn = "tmp.txt"
}

; ================================
; Hotstring
; ================================


;WSL
::xxx::bash "/mnt/c/Users/re438/OneDrive - g.ntu.edu.tw/bash/bk-asus-wsl-v1-to-dotfiles.sh"
::ssss::./show.sh
::xbashheader::{raw}#!/bin/bash
; ::tmuxrc::~/.tmux.conf.local

;Powershell
::sss::show
::fff::get-Bioclincal-repos
::rrr::. $profile; show
::ooo::open-profile
::vvv::Open-VsCodeNvim-init
;edit git, edit npm
::egit::code "$env:USERPROFILE\.gitconfig"
::enpm::code "$env:USERPROFILE\.npmrc"
::xwsl::wsl -d Ubuntu-20.04
::zzz::node C:\projects\puppeteer\src\puppet\scripts\checkPackage.js

; Bioclinica
::buser::ben.hu
::bpass::2Aoxjgju!
::aaa::npm run serve:src:open:dev
::lll::imageFileCacheAction
::ccc::vfauto1.user@bioclinica.com
::ddd::Pa$$w0rd
::eee::http://localhost:4200/?system-collection-id-pairs=sd-ex1000000011951294
::jjj::wsl /home/re4388/projects/dotfiles/bash_projects/jira_quick_link/jira_board.sh

F1::#d
;F2 for rename
F3::+!s ;screenshot
;F4 => below, search google
DetectHiddenWindows, On
;previous song
F5::PostMessage, 0x319,, 0xC0000,, ahk_exe Spotify.exe
;play/pause
F6::PostMessage, 0x319,, 0xE0000,, ahk_exe Spotify.exe
;next song
F7::PostMessage, 0x319,, 0xB0000,, ahk_exe Spotify.exe
F8::Volume_Mute
F9::Volume_Down
F10::Volume_Up


;^+Right::Send, {Volume_Up}
;^+Left::Send, {Volume_Down}
;^+Down::Send, {Volume_Mute}

; alt + j, k , l for (), [], {}
!j::
Send,(
return

!k::
Send,[
return

!l::
Send, {Raw}{
return

!;::
Send, {Raw}j
return

;git
::git-stash::git stash --include-untracked

; ttt => 20200829
:R*?:ttt::
FormatTime, CurrentDateTime,, yyyy_MM_dd_hh_mm
SendInput %CurrentDateTime%



; ENABLE use alt + arrow key to go line end and begin in every place
; like notion or simplenote
!Left::Send {Home}
!Right::Send {End}
!Up::Send {PgUp}
!Down::Send {PgDn}



; press ctrl+shift+n to open my tmp.txt in Onedrive
^+t::
    ; myPath := "C:\Users\re438\OneDrive - g.ntu.edu.tw\notepad-backup\tmp.txt"
    ; myPath := %OneDriveTmpNotepad_path%
    ; SplitPath, myPath,,,,fName
    Run,"notepad.exe" %OneDriveTmpNotepad_path%
    If WinExist("tmp.txt")
        WinActivate
    Return


; try to replace 全半形切換 to nothing in 自然輸入法
+Space::


; ================================
; Open...something
; ================================

; CHANGE CAPSLOCK TO CTRL AND ALSO ENABLE ALL ORIGINAL CTRL + X COMBO
; https://gist.github.com/yyolk/fddf44b973e6008f0667fc4b3346cbda
; https://gist.github.com/sedm0784/4443120
g_LastCtrlKeyDownTime := 0
g_AbortSendEsc := false
g_ControlRepeatDetected := false

*CapsLock::
    if (g_ControlRepeatDetected)
    {
        return
    }

    send,{Ctrl down}
    g_LastCtrlKeyDownTime := A_TickCount
    g_AbortSendEsc := false
    g_ControlRepeatDetected := true

    return

*CapsLock Up::
    send,{Ctrl up}
    g_ControlRepeatDetected := false
    if (g_AbortSendEsc)
    {
        return
    }
    current_time := A_TickCount
    time_elapsed := current_time - g_LastCtrlKeyDownTime
    if (time_elapsed <= 250)
    {
        SendInput {Esc}
    }
    return

~*^a::
~*^b::
~*^c::
~*^d::
~*^e::
~*^f::
~*^g::
~*^h::
~*^i::
~*^j::
~*^k::
~*^l::
~*^m::
~*^n::
~*^o::
~*^p::
~*^q::
~*^r::
~*^s::
~*^t::
~*^u::
~*^v::
~*^w::
~*^x::
~*^y::
~*^z::
~*^1::
~*^2::
~*^3::
~*^4::
~*^5::
~*^6::
~*^7::
~*^8::
~*^9::
~*^0::
~*^Space::
~*^Backspace::
~*^Delete::
~*^Insert::
~*^Home::
~*^End::
~*^PgUp::
~*^PgDn::
~*^Tab::
~*^Return::
~*^,::
~*^.::
~*^/::
~*^;::
~*^'::
~*^[::
~*^]::
~*^\::
~*^-::
~*^=::
~*^`::
~*^F1::
~*^F2::
~*^F3::
~*^F4::
~*^F5::
~*^F6::
~*^F7::
~*^F8::
~*^F9::
~*^F10::
~*^F11::
~*^F12::
    g_AbortSendEsc := true
    return



; ctrl + shift + g => open chrome and search stuff you selected
; ref: https://dilpreet.dev/blog/autohotkey-for-developers/
+^g::
OpenHighlighted()
return

OpenHighlighted()
{
  MyClipboard := "" ; Clears variable


  Send, {ctrl down}c{ctrl up} ; More secure way to Copy things
  sleep, 50 ; Delay
  MyClipboard := RegexReplace( clipboard, "^\s+|\s+$" ) ; Trim additional spaces and line return
  sleep, 50
  MyStripped := StrReplace(MyClipboard, " ", "") ; Removes every spaces in the string.


  StringLeft, OutputVarUrl, MyStripped, 8 ; Takes the 8 firsts characters
  StringLeft, OutputVarLocal, MyStripped, 3 ; Takes the 3 first characters
  sleep, 50

  ; it will auto-detect if the selected line prefix with http and just use this as target and run it
  ; and it it is prefix with file folder, like C:/, it will open the folder
  ; o.w, it will use google to search the term
  ;
  ; NOTE: this auto-detect is not working in current vscode-neovim
  ; since when you select, it work differently when selecting in notepad
  if (OutputVarUrl == "http://" || OutputVarUrl == "https://")
    Desc := "URL", Target := MyStripped
  else if (OutputVarLocal == "C:/" || OutputVarLocal == "C:\" || OutputVarLocal == "Z:/" || OutputVarLocal == "Z:\" || OutputVarLocal == "R:/" || OutputVarLocal == "R:\" ||)
    Desc := "Windows", Target := MyClipboard
  else
    Desc := "GoogleSearch", Target := "http://www.google.com/search?q=" MyClipboard


  ;TrayTip,, %Desc%: "%MyClipboard%" ;
  Sleep,50
  Run, %Target%
  Return
}





; ENABLE USE WIN + NUMNBER KEY TO SWITCH VIRTUAL DESKTOP

; Globals
DesktopCount = 2 ; Windows starts with 2 desktops at boot
CurrentDesktop = 1 ; Desktop count is 1-indexed (Microsoft numbers them this way)
;
; This function examines the registry to build an accurate list of the current virtual desktops and which one we're currently on.
; Current desktop UUID appears to be in HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\SessionInfo\1\VirtualDesktops
; List of desktops appears to be in HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VirtualDesktops
;
mapDesktopsFromRegistry() {
 global CurrentDesktop, DesktopCount
 ; Get the current desktop UUID. Length should be 32 always, but there's no guarantee this couldn't change in a later Windows release so we check.
 IdLength := 32
 SessionId := getSessionId()
 if (SessionId) {
 RegRead, CurrentDesktopId, HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\SessionInfo\%SessionId%\VirtualDesktops, CurrentVirtualDesktop
 if (CurrentDesktopId) {
 IdLength := StrLen(CurrentDesktopId)
 }
 }
 ; Get a list of the UUIDs for all virtual desktops on the system
 RegRead, DesktopList, HKEY_CURRENT_USER, SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VirtualDesktops, VirtualDesktopIDs
 if (DesktopList) {
 DesktopListLength := StrLen(DesktopList)
 ; Figure out how many virtual desktops there are
 DesktopCount := DesktopListLength / IdLength
 }
 else {
 DesktopCount := 1
 }
 ; Parse the REG_DATA string that stores the array of UUID's for virtual desktops in the registry.
 i := 0
 while (CurrentDesktopId and i < DesktopCount) {
 StartPos := (i * IdLength) + 1
 DesktopIter := SubStr(DesktopList, StartPos, IdLength)
 OutputDebug, The iterator is pointing at %DesktopIter% and count is %i%.
 ; Break out if we find a match in the list. If we didn't find anything, keep the
 ; old guess and pray we're still correct :-D.
 if (DesktopIter = CurrentDesktopId) {
 CurrentDesktop := i + 1
 OutputDebug, Current desktop number is %CurrentDesktop% with an ID of %DesktopIter%.
 break
 }
 i++
 }
}
;
; This functions finds out ID of current session.
;
getSessionId()
{
 ProcessId := DllCall("GetCurrentProcessId", "UInt")
 if ErrorLevel {
 OutputDebug, Error getting current process id: %ErrorLevel%
 return
 }
 OutputDebug, Current Process Id: %ProcessId%
 DllCall("ProcessIdToSessionId", "UInt", ProcessId, "UInt*", SessionId)
 if ErrorLevel {
 OutputDebug, Error getting session id: %ErrorLevel%
 return
 }
 OutputDebug, Current Session Id: %SessionId%
 return SessionId
}
;
; This function switches to the desktop number provided.
;
switchDesktopByNumber(targetDesktop)
{
 global CurrentDesktop, DesktopCount
 ; Re-generate the list of desktops and where we fit in that. We do this because
 ; the user may have switched desktops via some other means than the script.
 mapDesktopsFromRegistry()
 ; Don't attempt to switch to an invalid desktop
 if (targetDesktop > DesktopCount || targetDesktop < 1) {
 OutputDebug, [invalid] target: %targetDesktop% current: %CurrentDesktop%
 return
 }
 ; Go right until we reach the desktop we want
 while(CurrentDesktop < targetDesktop) {
 Send ^#{Right}
 CurrentDesktop++
 OutputDebug, [right] target: %targetDesktop% current: %CurrentDesktop%
 }
 ; Go left until we reach the desktop we want
 while(CurrentDesktop > targetDesktop) {
 Send ^#{Left}
 CurrentDesktop--
 OutputDebug, [left] target: %targetDesktop% current: %CurrentDesktop%
 }
}
;
; This function creates a new virtual desktop and switches to it
;
createVirtualDesktop()
{
 global CurrentDesktop, DesktopCount
 Send, #^d
 DesktopCount++
 CurrentDesktop = %DesktopCount%
 OutputDebug, [create] desktops: %DesktopCount% current: %CurrentDesktop%
}
;
; This function deletes the current virtual desktop
;
deleteVirtualDesktop()
{
 global CurrentDesktop, DesktopCount
 Send, #^{F4}
 DesktopCount--
 CurrentDesktop--
 OutputDebug, [delete] desktops: %DesktopCount% current: %CurrentDesktop%
}
; Main
SetKeyDelay, 75
mapDesktopsFromRegistry()
OutputDebug, [loading] desktops: %DesktopCount% current: %CurrentDesktop%
; User config!
; This section binds the key combo to the switch/create/delete actions
LWin & 1::switchDesktopByNumber(1)
LWin & 2::switchDesktopByNumber(2)
LWin & 3::switchDesktopByNumber(3)
LWin & 4::switchDesktopByNumber(4)
LWin & 5::switchDesktopByNumber(5)
LWin & 6::switchDesktopByNumber(6)
LWin & 7::switchDesktopByNumber(7)
LWin & 8::switchDesktopByNumber(8)
LWin & 9::switchDesktopByNumber(9)

