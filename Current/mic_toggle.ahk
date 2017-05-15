#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

Pause:: ;Pause Break button is my chosen hotkey

SoundSet, +1, MASTER, mute,11 ;12 was my mic id number use the code below the dotted line to find your mic id. you need to replace all 12's <---------IMPORTANT
SoundGet, master_mute, , mute, 11

ToolTip, Mute %master_mute% ;use a tool tip at mouse pointer to show what state mic is after toggle
SetTimer, RemoveToolTip, 1000
return

RemoveToolTip:
SetTimer, RemoveToolTip, Off
ToolTip
return
