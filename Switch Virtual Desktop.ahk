#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

!WheelDown::SendInput {LCtrl down}{LWin down}{Right}{LCtrl up}{LWin up}
!WheelUp::SendInput {LCtrl down}{LWin down}{Left}{LCtrl up}{LWin up}
!n::SendInput {LCtrl down}{LWin down}{Right}{LCtrl up}{LWin up}
!b::SendInput {LCtrl down}{LWin down}{Left}{LCtrl up}{LWin up}