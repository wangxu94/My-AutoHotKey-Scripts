#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.

; Kill all scripts on Win Alt x

#!x::
DetectHiddenWindows On ; List all running instances of this script:
WinGet instances, List, ahk_class AutoHotkey
if (instances > 1) { ; There are 2 or more instances of this script.
    this_pid := DllCall("GetCurrentProcessId"),  closed := 0
    Loop % instances { ; For each instance,
        WinGet pid, PID, % "ahk_id " instances%A_Index%
        if (pid != this_pid) { ; If it's not THIS instance,
            WinClose % "ahk_id " instances%A_Index% ; close it.
            closed += 1
        }
    }
    MsgBox Closed %closed% instance of this script.
}
#Persistent ; Don't exit automatically for this test.
#SingleInstance Off ; Allow new instances to start.
Return

; Start all scripts on Win Alt z

#!z::

Run, "C:\Users\Xu\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\Xplorer2.exe"
Run, "C:\Users\Xu\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\vim mode.exe"
Run, "C:\Users\Xu\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\Hot Corners.exe"
Run, "C:\Users\Xu\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\Google v2.exe"
Return