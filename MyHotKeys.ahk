; ---------------------------------------
; HOT CORNERS
; ---------------------------------------

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
	
; -------------------------------
; VIM MODE
; -------------------------------
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
; Minimize on Caps
+Capslock::Capslock
Capslock::WinMinimize,A

; Global variables
inputNumber := " "

; Notification GUI {{{
notify(text, time = 2000)
{
    #IfWinExist VIM-Mode commands
        resetGUI()
    #IfWinExist
    ; Set the flags for OSD
    Gui, 90:+AlwaysOnTop -Caption +ToolWindow +Disabled -SysMenu +Owner
    ; Add and set the OSD Text
    Gui, 90:Font, s10 bold
    Gui, 90:Add, Text, cAA0000, %text%
    ; OSD Background Color (Black)
    Gui, 90:Color, 000000
    Gui, 90:Show,NoActivate xCenter yCenter, VIM-Mode commands
    Sleep, %time%
    Gui, 90:Destroy
    return
} ;}}}

; HotKey to Initiate VI-mode with Double-tap of Esc {{{
$Esc::
    If (A_PriorHotKey = "$Esc" AND A_TimeSincePriorHotKey < 500)
    {                                
        ; Set the flags for OSD
        Gui, 99:+AlwaysOnTop -Caption +ToolWindow +Disabled -SysMenu +Owner
        ; Add and set the OSD Text
        Gui, 99:Font, s15 bold
        Gui, 99:Add, Text, cAA0000, VI-Mode Activated (Esc to Exit)
        ; OSD Background Color (Black)
        Gui, 99:Color, 000000
        Gui, 99:Show,NoActivate x0 y10, VIM-Mode Activated
    }
    Else
    {
        SendInput {Esc}
    }
Return ; }}}

#IfWinExist VIM-Mode Activated ; {{{

    ; ESC ends VIM-mode
    ESC:: 
    {
        if (inputNumber != " ")
        {
            resetInputNumber()
            return
        }
        else
        {
            endVIM()
            return
        }
    }

    ; i(nput) end VIM-mode
    i::
    {
        endVIM()
        return
    }

    ; Other input modes ...
    +i:: 
    {
        SendInput {Home}
        endVIM()
        return
    }
    a::
    {
        SendInput {Right}
        endVIM()
        return
    }
    +a::
    {
        SendInput {End}
        endVIM()
        return
    }

    ; cursor movements
    h:: 
    {
        SendInput {Left %inputNumber%}
        resetInputNumber()
        return
    }
    j:: 
    {
        SendInput {Down %inputNumber%}
        resetInputNumber()
        return
    }
    k:: 
    {
        SendInput {Up %inputNumber%}
        resetInputNumber()
        return
    }
    l:: 
    {
        SendInput {Right %inputNumber%}
        resetInputNumber()
        return
    }

    ; page movements
    w:: 
    {
        SendInput ^{Right %inputNumber%}
        resetInputNumber()
        return
    }
    b:: 
    {
        SendInput ^{Left %inputNumber%}
        resetInputNumber()
        return
    }
    x:: 
    {
        SendInput {Delete %inputNumber%}
        resetInputNumber()
        return
    }
    0:: ; Add to the inputNumber if inputNumber != null, otherwise HOME
    {
        if (inputNumber != " ")
        {
            inputNumber = %inputNumber%0
            normalize(0)
            notify(inputNumber)
            return
        }
        else
        {
            SendInput {Home}
            resetInputNumber()
            return
        }
    }
    -:: 
    {
        SendInput {End}
        resetInputNumber()
        return
    }
    $:: 
    {
        SendInput {End}
        resetInputNumber()
        return
    }

    ; selection movements with Shift
    +h:: 
    {
        SendInput +{Left %inputNumber%}
        resetInputNumber()
        return
    }
    +j:: 
    {
        SendInput +{Down %inputNumber%}
        resetInputNumber()
        return
    }
    +k:: 
    {
        SendInput +{Up %inputNumber%}
        resetInputNumber()
        return
    }
    +l::
    {
        SendInput +{Right %inputNumber%}
        resetInputNumber()
        return
    }
    +w:: 
    {
        SendInput +^{Right %inputNumber%}
        resetInputNumber()
        return
    }
    +b:: 
    {
        SendInput +^{Left %inputNumber%}
        resetInputNumber()
        return
    }
    +x:: 
    {
        SendInput +{Delete}
        resetInputNumber()
        return
    }
    ):: 
    {
        SendInput +{Home}
        resetInputNumber()
        return
    }
    _:: 
    {
        SendInput +{End}
        resetInputNumber()
        return
    }

    ; Copy (Yank) / Cut (Delete) / Paste (Put)
    y:: 
    {
        SendInput ^c
        resetInputNumber()
        return
    }
    p:: 
    {
        SendInput ^v
        resetInputNumber()
        return
    }
    d:: 
    {
        SendInput ^x
        resetInputNumber()
        return
    }

    ; Search with /
    /::
    {
        SendInput ^f
        resetInputNumber()
        return
    }

    ; HotKey to VIM maps
    u:: 
    {
        SendInput ^z
        resetInputNumber()
        return
    }

    ; Catch numbers to repeat commands
    $1::
    {
       inputNumber = %inputNumber%1
       normalize(1)
       notify(inputNumber)
       return
    }

    $2::
    {
       inputNumber = %inputNumber%2
       normalize(2)
       notify(inputNumber)
       return
    }

    $3::
    {
       inputNumber = %inputNumber%3
       normalize(3)
       notify(inputNumber)
       return
    }

    $4::
    {
       inputNumber = %inputNumber%4
       normalize(4)
       notify(inputNumber)
       return
    }

    $5::
    {
       inputNumber = %inputNumber%5
       normalize(5)
       notify(inputNumber)
       return
    }

    $6::
    {
       inputNumber = %inputNumber%6
       normalize(6)
       notify(inputNumber)
       return
    }

    $7::
    {
       inputNumber = %inputNumber%7
       normalize(7)
       notify(inputNumber)
       return
    }

    $8::
    {
       inputNumber = %inputNumber%8
       normalize(8)
       notify(inputNumber)
       return
    }

    $9::
    {
       inputNumber = %inputNumber%9
       normalize(9)
       notify(inputNumber)
       return
    }
        
#IfWinExist ;}}}

;;; Ad-hoc Vi navigation with Space + key combo {{{

Space & F1::Return
; send explicitly when no other key is pressed before release
*Space:: SendInput {Blind}{Space}
;  KeyDown:=A_TickCount
;  KeyWait /
;  if (A_TickCount-KeyDown < 1000)
;     Send {Space}
;  Return

#If GetKeyState("Space", "p")

; cursor movements
 h::left 
 j::down 
 k::up 
 l::right 

; page movements
 w::^right
 b::^left 
 x::delete 
 0::home 
 -::end 
 $::end 


; HotKey to VIM maps
 u:: SendInput ^z

; Change file name
 i:: SendInput {F2}

#If

; }}}

; Validate the inputNumber and make sure that it's less than 500 {{{
normalize(resetNumber)
{
    global inputNumber
    if (inputNumber > 500)
    {
        inputNumber := resetNumber
    }
} ;}}}

; Reset the inputNumber to " "
resetInputNumber()
{              
   global
   resetGUI()
   inputNumber := " "
   return
}

resetGUI()
{
    Gui, 90:Destroy
    return
}
endVIM()
{
    Gui, 99:Destroy
    resetInputNumber()
    return
}

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

!WheelDown::SendInput {LCtrl down}{LWin down}{Right}{LCtrl up}{LWin up}
!WheelUp::SendInput {LCtrl down}{LWin down}{Left}{LCtrl up}{LWin up}
!k::SendInput {LCtrl down}{LWin down}{Right}{LCtrl up}{LWin up}
!j::SendInput {LCtrl down}{LWin down}{Left}{LCtrl up}{LWin up}

#!x::ExitApp