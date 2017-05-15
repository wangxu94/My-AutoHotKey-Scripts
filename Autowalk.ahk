#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#MaxThreadsPerHotkey, 2

looping = 0

`::

keywait, XButton1

looping := !looping

if (!looping)
{
    Return
}

loop
{
    If (!looping)
    {
        break
    }

    send, {w down}
    sleep, 30
}

send, {w up}
return

F1::
{
    ExitApp
}
return