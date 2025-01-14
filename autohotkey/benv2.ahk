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


::ccc::send (用繁體中文解釋)

 

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




;;;;;;;;;;; ([{}]) ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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





;;;;;;;;;;; back and forward ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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


;;;;;;;;;;; HOME and END ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; 因為 max mini沒有 home and end, 所以這邊的設定會比較複雜
; 1. 使用 alt + left, right 來做為 global home and end
; alt + left, right -> go line begin, go line end
!Left::Send {Home}
!Right::Send {End}


; 這邊我習慣用 alt + [ 和 alt + ] 來做為 go to file top, go to bottom only in intellij idea (intelliJ 好像沒有keymap可以設定)
; 然後 vscode 的設定，使用 vscode 的熱鍵去設定 cursorTop and cursorBottom
; alt +[/] -> go to file top, go to bottom
#IfWinActive ahk_exe idea64.exe
![::Send ^{Home}
!]::Send ^{End}
#IfWinActive


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



