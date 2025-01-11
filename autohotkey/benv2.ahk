;  +  shift
;  !  alt
;  ^  ctrl
;  #  window key

; ================================
; Hotstring
; ================================
;Powershell
; ::ahkfff::get-Bioclincal-repos
::ahkrrr::. $profile; show
::ahkooo::open-profile

;git
; ::ahkstash::git stash --include-untracked

::ttt::
FormatTime, TimeString,, yyyy_MM_dd_hh_mm
send %TimeString%
return


; ================================
; Notion specific hotkey added
; ================================


#IfWinActive ahk_class Chrome_WidgetWin_1 ahk_exe Notion.exe

; use alt+e to open recently page, same shortcut in vscode
!e::
   send,^p
   return

; use alt+q to go back to history
!q::
   send,^[
   return

; use alt+i to go forward to history
!a::
   send,^]
   return


; use alt+e to open recently page, same shortcut in vscode
!d::Send, {Delete}

#IfWinActive  ; This puts subsequent remappings and hotkeys in effect for all windows.



; ================================
; Volume control
; ================================

F11::Volume_Mute
F12::Volume_Down
; F13::Volume_Up
Insert::Send, {Volume_Up}


; ================================
; Remap Windows Key + V to Alt + ;
; ================================

; alt + v -> win+v( win built in clipboard history) 
!;::Send #v


; ================================
; Code helper
; ================================

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




; 這邊先設定 explorer 的 alt+q, alt+a 來做為 go back, go forward
; 然後下面全範圍的 alt+left, alt+right 來做為 go line begin, go line end
; 結論就是 explorer 的 alt+q, alt+a 會有效果，然其他 app 都可以使用 alt+left, alt+right 來做為 go line begin, go line end
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#IfWinActive ahk_exe explorer.exe
!q::Send, !{Left}
!a::Send, !{right}
#IfWinActive

#IfWinActive ahk_exe chrome.exe
!q::Send, !{Left}
!a::Send, !{right}
#IfWinActive


!Left::Send {Home}
!Right::Send {End}

; CapsLock/Control/RightAlt remap
CapsLock::Control
F9::CapsLock


; https://gist.github.com/volks73/1e889e01ad0a736159a5d56268a300a8
; *CapsLock::
;     Send {Blind}{Ctrl Down}
;     cDown := A_TickCount
; Return

; *CapsLock up::
;     If ((A_TickCount-cDown)<400)  ; Modify press time as needed (milliseconds)
;         Send {Blind}{Ctrl Up}{Esc}
;     Else
;         Send {Blind}{Ctrl Up}
; Return



; 下面這個可以 disable, 但還是無法解決我會遇到的 bug
; this is ver2 syntax
; SetCapsLockState 'AlwaysOff'
; CapsLock::Return ; ver1

; ================================
; CAPSLOCK replace Ctrl
; ================================



; CHANGE CAPSLOCK TO CTRL AND ALSO ENABLE ALL ORIGINAL CTRL + X COMBO
; https://gist.github.com/yyolk/fddf44b973e6008f0667fc4b3346cbda
; https://gist.github.com/sedm0784/4443120




; g_LastCtrlKeyDownTime := 0
; g_AbortSendEsc := false
; g_ControlRepeatDetected := false

; *CapsLock::
;     if (g_ControlRepeatDetected)
;     {
;         return
;     }

;     send,{Ctrl down}
;     g_LastCtrlKeyDownTime := A_TickCount
;     g_AbortSendEsc := false
;     g_ControlRepeatDetected := true

;     return

; *CapsLock Up::
;     send,{Ctrl up}
;     g_ControlRepeatDetected := false
;     if (g_AbortSendEsc)
;     {
;         return
;     }
;     current_time := A_TickCount
;     time_elapsed := current_time - g_LastCtrlKeyDownTime
;     if (time_elapsed <= 250)
;     {
;         SendInput {Esc}
;     }
;     return

; ~*^a::
; ~*^b::
; ~*^c::
; ~*^d::
; ~*^e::
; ~*^f::
; ~*^g::
; ~*^h::
; ~*^i::
; ~*^j::
; ~*^k::
; ~*^l::
; ~*^m::
; ~*^n::
; ~*^o::
; ~*^p::
; ~*^q::
; ~*^r::
; ~*^s::
; ~*^t::
; ~*^u::
; ~*^v::
; ~*^w::
; ~*^x::
; ~*^y::
; ~*^z::
; ~*^1::
; ~*^2::
; ~*^3::
; ~*^4::
; ~*^5::
; ~*^6::
; ~*^7::
; ~*^8::
; ~*^9::
; ~*^0::
; ~*^Space::
; ~*^Backspace::
; ~*^Delete::
; ~*^Insert::
; ~*^Home::
; ~*^End::
; ~*^PgUp::
; ~*^PgDn::
; ~*^Tab::
; ~*^Return::
; ~*^,::
; ~*^.::
; ~*^/::
; ~*^;::
; ~*^'::
; ~*^[::
; ~*^]::
; ~*^\::
; ~*^-::
; ~*^=::
; ~*^`::
; ~*^F1::
; ~*^F2::
; ~*^F3::
; ~*^F4::
; ~*^F5::
; ~*^F6::
; ~*^F7::
; ~*^F8::
; ~*^F9::
; ~*^F10::
; ~*^F11::
; ~*^F12::
;     g_AbortSendEsc := true
;     return


