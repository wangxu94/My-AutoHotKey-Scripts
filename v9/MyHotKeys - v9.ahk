; ---------------------------
; HOT CORNERS
; ---------------------------

#Persistent

; The following script can define hotcorners for any number of monitors arranged in any configuration.
; Horizontally arranged monitors work best
; Vertically arranged monitors may have some difficulty (read: over sensitivity since moving your mouse too far up puts it into Bottom*, not Top*), but should still work


; ---------------------------------------
; USER CONFIGURABLE
; ---------------------------------------
global T = 5   ; Adjust tolerance if needed
global DEBUG := False

; Put your hotcorner actions here
Action_TopLeft() {
        Send, {LWin down}{Tab down}
        Send, {Lwin up}{Tab up}
}
Action_BottomRight() {

}
Action_BottomLeft() {

}
Action_TopRight() {

}

; ---------------------------------
; SETUP
; ---------------------------------

global ScreenArray := Object()

; Get the number of monitors
SysGet, NumMonitors, MonitorCount

; Insert a new empty array for each monitor
Loop %NumMonitors% {
        ScreenArray.Insert(Object())
}

; For each monitor, get the dimensions as coordinates
for index, element in ScreenArray 
{
        ; get monitor details for this index (These are 1 based indexes)
        SysGet, Mon, Monitor, %index%
        element.Insert(MonLeft)
        element.Insert(MonTop)
        element.Insert(MonRight)
        element.insert(MonBottom)
}

GetCorner(x, y, cornerIndex, tolerance)
{
    ; loop through each monitor
    for idx, elem in ScreenArray
    {
        if (cornerIndex == 0) { ; Top Left
            ; If statements are so it doesn't break the for loop on the first false. It will only return if true
            if (x >= elem[1] and x <= elem[1] + tolerance) and (y >= elem[2] and y <= elem[2] + tolerance) {
                return True
            }
        } else if (cornerIndex == 1) { ; Top Right
            if (x >= elem[3] - tolerance and x <= elem[3]) and (y >= elem[2] and y <= elem[2] + tolerance) {
                return True
            }
        } else if (cornerIndex == 2) { ; Bottom Right
            if (x >= elem[3] - tolerance and x <= elem[3]) and (y >= elem[4] - tolerance and y <= elem[4]) {
                return True
            }
        } else { ; Bottom Left
            if (x >= elem[1] and x <= elem[1] + tolerance) and (y >= elem[4] - tolerance and y <= elem[4]) {
                return True
            }
        }
    }
}

; --------------------------
; MOUSE DETECTION LOOP
; --------------------------

SetTimer, HotCorners, 500
return

HotCorners:
    CoordMode, Mouse, Screen
    MouseGetPos, MouseX, MouseY

    if GetCorner(MouseX, MouseY, 0, T) {    ; TopLeft
        Action_TopLeft()
        Sleep, 1000
        if (DEBUG) {
            Msgbox, Top Left %MouseX%,%MouseY% 
        }
    } else if GetCorner(MouseX, MouseY, 1, T) {     ; TopRight
        Action_TopRight()
        Sleep, 1000
        if (DEBUG) { 
           Msgbox, Top Right %MouseX%,%MouseY% 
        }
    } else if GetCorner(MouseX, MouseY, 3, T) {     ; BottomLeft
        Action_BottomLeft()
        Sleep, 1000
        if (DEBUG) { 
            Msgbox, Bottom Left %MouseX%,%MouseY% 
        }
    } else if GetCorner(MouseX, MouseY, 2, T) {     ; BottomRight
        Action_BottomRight()
        Sleep, 1000
        if (DEBUG) { 
            Msgbox, Bottom Right %MouseX%, %MouseY% 
        }
    }
	

; --------------------------------------
; VIM NAVIGATION WITH CAPSLOCK
; --------------------------------------

; ONENOTE SPECIFIC

#IfWinActive, ahk_class Framework::CFrame
Capslock & j::SendInput ^{Down}
Capslock & k::SendInput ^{Up}
#IfWinActive

; GENERAL

Capslock & -::SendInput {End}
Capslock & 0::SendInput {Home}
Capslock & i::SendInput {PgUp}
Capslock & u::SendInput {PgDn}
Capslock & w::SendInput ^{Right}
Capslock & b::SendInput ^{Left}
Capslock & h::SendInput {Left}
Capslock & l::SendInput {Right}
Capslock & j::SendInput {Down}
Capslock & k::SendInput {Up}
Capslock & /::SendInput {LCtrl down}{f}{LCtrl up}
Capslock & x::SendInput {Del}

; -------------------------------
; GOOGLE
; -------------------------------

; Google Search
; Fanatic Guru
; 2014 10 14
; Version: 1.2
;
; Google Search of Highlighted Text
;
;{-----------------------------------------------
; If Internet Explorer is already running it will add search as new tab
;}

; INITIALIZATION - ENVIROMENT
;{-----------------------------------------------
;
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force  ; Ensures that only the last executed instance of script is running
;}

; AUTO-EXECUTE
;{-----------------------------------------------
;
RegRead, ProgID, HKEY_CURRENT_USER, Software\Microsoft\Windows\Shell\Associations\UrlAssociations\http\UserChoice, Progid
Browser := "iexplore.exe"
if (ProgID = "ChromeHTML")
   Browser := "chrome.exe"
if (ProgID = "FirefoxURL")
   Browser := "firefox.exe"
;
;}-----------------------------------------------
; END OF AUTO-EXECUTE

; HOTKEYS
;{-----------------------------------------------
;
^g::    ; <-- Google Web Search Using Highlighted Text
   Search := 1
   Gosub Google
return

^+g::    ; <-- Google Image Search Using Highlighted Text
   Search := 2
   Gosub Google
return

^!g::    ; <-- Google Map Search Using Highlighted Text
   Search := 3
   Gosub Google
return
;}

; SUBROUTINES
;{-----------------------------------------------
;
Google:
   Save_Clipboard := ClipboardAll
   Clipboard := ""
   Send ^c
   ClipWait, .5
   if !ErrorLevel
      Query := Clipboard
   else
      InputBox, Query, Google Search, , , 200, 100, , , , , %Query%
   StringReplace, Query, Query, `r`n, %A_Space%, All 
   StringReplace, Query, Query, %A_Space%, `%20, All
   StringReplace, Query, Query, #, `%23, All
   Query := Trim(Query)
   if (Search = 1)
      Address := "http://www.google.com/search?hl=en&q=" Query ; Web Search
   else if (Search = 2)
      Address := "http://www.google.com/search?site=imghp&tbm=isch&q=" Query ; Image Search
   else
      Address := "http://www.google.com/maps/search/" Query ; Map Search
   if (Browser = "iexplore.exe")
   {
      Found_IE := false
      For wb in ComObjCreate("Shell.Application").Windows 
         If InStr(wb.FullName, "iexplore.exe")
         {
            Found_IE := true
         	break
         }
      if Found_IE
         wb.Navigate(Address, 2048) 
      else
      {
         wb := ComObjCreate("InternetExplorer.Application")
         wb.Visible := true
         wb.Navigate(Address) 
      }
   }
   else
      Run, "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" %Address% 
   Clipboard := Save_Clipboard
   Save_Clipboard := ""
return
;}

; --------------------------------
; Xplorer2
; --------------------------------

#e:: Run, C:\Program Files\zabkat\xplorer2\xplorer2_64.exe /M

; --------------------------------
; SWITCH VIRTUAL DESKTOP
; --------------------------------

!WheelDown::SendInput {LCtrl down}{LWin down}{Right}{LCtrl up}{LWin up}{LAlt down}{Tab}{LAlt up}
!WheelUp::SendInput {LCtrl down}{LWin down}{Left}{LCtrl up}{LWin up}{LAlt down}{Tab}{LAlt up}
!k::SendInput {LCtrl down}{LWin down}{Right}{LCtrl up}{LWin up}{LAlt down}{Tab}{LAlt up}
!j::SendInput {LCtrl down}{LWin down}{Left}{LCtrl up}{LWin up}{LAlt down}{Tab}{LAlt up}

; --------------------------------
; SWITCH TABS
; --------------------------------

+WheelDown::SendInput {LCtrl down}{Tab}{LCtrl up}
+WheelUp::SendInput {LCtrl down}{LShift down}{Tab}{LCtrl up}{LShift up}

#!x::ExitApp