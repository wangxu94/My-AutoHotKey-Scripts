#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

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

; ---------------------------------------
; MOUSE DETECTION LOOP
; --------------------------------------

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


; ----------------------------------------------------
; VIM NAVIGATION WITH CAPSLOCK
; ---------------------------------------------------

; SELECTION WITH SHIFT
GetKeyState, state, Shift
{
	{
	Capslock & w::
		If state = D
			SendInput +^{Right}
		else
			SendInput ^{Right}
		return
	Capslock & b::
		If state = D
			SendInput +^{Left}
		else
			SendInput ^{Left}			
		return
	Capslock & h::
		If state = D
			SendInput +{Left}
		else
			SendInput {Left}		
		return
	Capslock & l::
		If state = D
			SendInput +{Right}
		else
			SendInput {Right}		
		return
	Capslock & j::
		If state = D
			SendInput +{Down}
		else
			SendInput {Down}		
		return
	Capslock & k::
		If state = D
			SendInput +{Up}
		else
			SendInput {Up}		
		return
	Capslock & -::
		If state = D
			SendInput +{End}
		else
			SendInput {End}
		return
	Capslock & 0::
		If state = D
			SendInput +{Home}
		else
			SendInput {Home}
		return
	}
; ONENOTE SPECIFIC

#IfWinActive, ahk_class Framework::CFrame
	{
	Capslock & j::
		If state = D
			SendInput +^{Down}
		else
			SendInput ^{Down}		
		return
	Capslock & k::
		If state = D
			SendInput +^{Up}
		else
			SendInput ^{Up}		
		return
	}
#IfWinActive
}
; GENERAL

Capslock & i::SendInput {PgUp}
Capslock & u::SendInput {PgDn}
Capslock & /::SendInput ^f
Capslock & x::SendInput {Del}
CapsLock & m::SendInput {WheelDown}
CapsLock & ,::SendInput {WheelUp}
; CapsLock & n::SendInput {WheelLeft}
; CapsLock & .::SendInput {WheelRight}
CapsLock & d::SendInput ^{Del}
CapsLock & c::SendInput {BackSpace}
CapsLock & f::SendInput ^{BackSpace}

; -------------------------------------
; VIM MODE
; -------------------------------------

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

; OneNote Specific
	
	#if winactive("ahk_class Framework::CFrame") && winexist("VIM-Mode")
	
	j:: 
    {
        SendInput ^{Down %inputNumber%}
        resetInputNumber()
        return
    }
    k:: 
    {
        SendInput ^{Up %inputNumber%}
        resetInputNumber()
        return
    }
	; Selection with Shift
	+j:: 
    {
        SendInput +^{Down %inputNumber%}
        resetInputNumber()
        return
    }
    +k:: 
    {
        SendInput +^{Up %inputNumber%}
        resetInputNumber()
        return
    }
	#If

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
    ^i::
    {
        endVIM()
		SendInput {LCtrl Up}
        return
    }
	
    ; Other input modes ...
		
	; General
	
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
	+g::
	{
		SendInput ^{End}
		Return
	}
	g::
	{
		SendInput ^{Home}
		Return
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
	m::
	{
		SendInput {WheelDown}
		resetInputNumber()
        return
	}
	,::
	{
		SendInput {WheelUp}
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
	; Toggle selection
	{
    v::SendInput {LShift down}
	+v::SendInput {LShift up}
	}
	
	{
	c::SendInput {LCtrl Down}
	^c::SendInput {LCtrl Up}
	}
	
    ; Copy (Yank) / Cut (Delete) / Paste (Put)
    y:: 
    {
        SendInput ^c
        resetInputNumber()
        return
    }
	^y:: 
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
    ^p:: 
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
#InputLevel 1
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
#InputLevel 0
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
; MultiCommander
; --------------------------------

;#e:: Run, "C:\Program Files\MultiCommander (x64)\MultiCommander.exe"

; --------------------------------
; Open with GVim
; --------------------------------

CapsLock & v:: 
Send, ^c
ClipWait ;waits for the clipboard to have content
Run, C:\Program Files (x86)\Vim\vim74\gvim.exe "%clipboard%"
Return 

; --------------------------------
; Open with Notepad++
; --------------------------------

CapsLock & e:: 
Send, ^c
ClipWait ;waits for the clipboard to have content
Run, C:\Program Files (x86)\Notepad++\notepad++.exe "%clipboard%"
Return 

; --------------------------------
; SWITCH VIRTUAL DESKTOP
; --------------------------------

!WheelDown::SendInput {LCtrl down}{LWin down}{Right}{LCtrl up}{LWin up}
!WheelUp::SendInput {LCtrl down}{LWin down}{Left}{LCtrl up}{LWin up}
!k::SendInput {LCtrl down}{LWin down}{Right}{LCtrl up}{LWin up}
!j::SendInput {LCtrl down}{LWin down}{Left}{LCtrl up}{LWin up}


; Globals
DesktopCount = 2        ; Windows starts with 2 desktops at boot
CurrentDesktop = 1      ; Desktop count is 1-indexed (Microsoft numbers them this way)

;
; This function examines the registry to build an accurate list of the current virtual desktops and which one we're currently on.
; Current desktop UUID appears to be in HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\SessionInfo\1\VirtualDesktops
; List of desktops appears to be in HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VirtualDesktops
;
mapDesktopsFromRegistry() {
    global CurrentDesktop, DesktopCount

    ; Get the current desktop UUID. Length should be 32 always, but there's no guarantee this couldn't change in a later Windows release so we check.
    RegRead, CurrentDesktopId, HKEY_CURRENT_USER, SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\SessionInfo\1\VirtualDesktops, CurrentVirtualDesktop
    IdLength := StrLen(CurrentDesktopId)

    ; Get a list of the UUIDs for all virtual desktops on the system
    RegRead, DesktopList, HKEY_CURRENT_USER, SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VirtualDesktops, VirtualDesktopIDs
    DesktopListLength := StrLen(DesktopList)

    ; Figure out how many virtual desktops there are
    DesktopCount := DesktopListLength/IdLength

    ; Parse the REG_DATA string that stores the array of UUID's for virtual desktops in the registry.
    i := 0
    while (i < DesktopCount) {
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
; This function switches to the desktop number provided.
;
switchDesktopByNumber(targetDesktop)
{
    global CurrentDesktop, DesktopCount

    ; Re-generate the list of desktops and where we fit in that. We do this because
    ; the user may have switched desktops via some other means than the script.
    mapDesktopsFromRegistry()

    ; Don't attempt to switch to an invalid desktop
    if (targetDesktop > DesktopCount || targetDesktop < 0) {
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
!1::switchDesktopByNumber(1)
!2::switchDesktopByNumber(2)
!3::switchDesktopByNumber(3)
!4::switchDesktopByNumber(4)
!5::switchDesktopByNumber(5)
!6::switchDesktopByNumber(6)
!7::switchDesktopByNumber(7)
!8::switchDesktopByNumber(8)
!9::switchDesktopByNumber(9)
; !k::switchDesktopByNumber(CurrentDesktop + 1)
; !j::switchDesktopByNumber(CurrentDesktop - 1)
; !WheelDown::switchDesktopByNumber(CurrentDesktop + 1)
; !WheelUp::switchDesktopByNumber(CurrentDesktop - 1)
!c::createVirtualDesktop()
!x::deleteVirtualDesktop()

; Alternate keys for this config. Adding these because DragonFly (python) doesn't send CapsLock correctly.
/*
^!1::switchDesktopByNumber(1)
^!2::switchDesktopByNumber(2)
^!3::switchDesktopByNumber(3)
^!4::switchDesktopByNumber(4)
^!5::switchDesktopByNumber(5)
^!6::switchDesktopByNumber(6)
^!7::switchDesktopByNumber(7)
^!8::switchDesktopByNumber(8)
^!9::switchDesktopByNumber(9)
^!n::switchDesktopByNumber(CurrentDesktop + 1)
^!p::switchDesktopByNumber(CurrentDesktop - 1)
^!s::switchDesktopByNumber(CurrentDesktop + 1)
^!a::switchDesktopByNumber(CurrentDesktop - 1)
^!c::createVirtualDesktop()
^!d::deleteVirtualDesktop()
*/

switchedDesktop := false
switchDesktop() 
{
  global switchedDesktop
    if switchedDesktop
    {
        SendEvent ^#{Right}
        switchedDesktop := false
    }
    else
    {
        SendEvent ^#{Left}
        switchedDesktop := true
    }
}

#`::switchDesktop()

;--------------------------------------
; Microsoft word
;--------------------------------------

CapsLock & q::SendInput ^+y ; Zotero add/edit citation


;--------------------------------------
; Word Count
;--------------------------------------

^e::
ClipSaved := ClipboardAll   ; Save the entire clipboard to a variable of your choice. 
Clipboard :=  
Send ^c 
; Send {Left} 
ClipWait, 2 
StringReplace, clipboard, clipboard, ', x, All
ClipWait, 2
StringReplace, clipboard, clipboard, -, x, All
RegExReplace( Clipboard, "\w+", "", Count ) ; PhiLho 
Clipboard := ClipSaved 

; To have a ToolTip disappear after a certain amount of time
; without having to use Sleep (which stops the current thread):
#Persistent
ToolTip, Word Count: %Count%
SetTimer, RemoveToolTip, 5000
return

RemoveToolTip:
SetTimer, RemoveToolTip, Off
ToolTip
Return


; --------------------------------
; SWITCH TABS
; --------------------------------

^WheelDown::SendInput {LCtrl down}{Tab}{LCtrl up}
^WheelUp::SendInput {LCtrl down}{LShift down}{Tab}{LCtrl up}{LShift up}
^k::SendInput {LCtrl down}{Tab}{LCtrl up}
^j::SendInput {LCtrl down}{LShift down}{Tab}{LCtrl up}{LShift up}

; ----------------------------------
; MINIMISE WINDOW
; ----------------------------------
CapsLock & `::WinMinimize,A
`::SendInput {LAlt down}{Tab}{LAlt up}


;--------------------------------------
; SWITCH WINDOWS
;--------------------------------------
/*
MButton::AltTabMenu
WheelDown::AltTab
WheelUp::ShiftAltTab
*/

Rbutton & LButton::AltTab
$RButton::MouseClick, right
/*
+WheelDown::SendInput {LAlt down}{Tab}{LAlt up}
+WheelUp::SendInput {LAlt down}{LShift down}{Tab}{LAlt up}{LShift up}
*/


;-————————————-
; Arrange Windows
;—————————————
/*
CapsLock & 1::SendInput {LWin Down}{Left}{LWin Up}
CapsLock & 2::SendInput {LWin Down}{Down}{LWin Up}
CapsLock & 3::SendInput {LWin Down}{Up}{LWin Up}
CapsLock & 4::SendInput {LWin Down}{Right}{LWin Up}
*/

;—————————————
; Media Controls
;—————————————

CapsLock & p::SendInput {Media_Play_Pause}

; MPC-HC Specific

CapsLock & [::
MediaPlayerClassicHC_JumpForward()
	{
	SendMessage,0x0111,902,,,ahk_class MediaPlayerClassicW
	}
Return

CapsLock & o::
MediaPlayerClassicHC_JumpBackward()
	{
	SendMessage,0x0111,901,,,ahk_class MediaPlayerClassicW
	}
Return

;----------------------------------------
; RIGHT CLICK
;----------------------------------------

CapsLock & r::SendInput {AppsKey}

; --------------------------------------
; MONITOR OFF
; --------------------------------------
^!m::Run, "C:\Windows\nircmd.exe" cmdwait 1000 monitor off

;------------------------------------
; Sleep
;-------------------------------------

^!s::Run, "C:\Windows\nircmd.exe" standby


;-------------------------------------
; Backup
;-------------------------------------

#!b::Run, bash -c "/home/wangxu/backup.sh"


;———————————
; urxvt
;———————————

CapsLock & t::Run, bash.exe ~ -c "(DISPLAY=:0 urxvtc &)"


;-———————————-
; ONENOTE SPECIFIC
;————————————

#IfWinActive, ahk_class Framework::CFrame
	{
	SendLevel 0
;	Capslock & t::
;		SendInput ^!1^uTable of Contents{Enter}`-{Space}
;		return
	CapsLock & g::
		SendInput ^g
		return
	CapsLock & 1::
		SendInput ^!1
		return
	CapsLock & 2::
		SendInput ^!2
		return
	CapsLock & 3::
		SendInput ^!3
		return
	CapsLock & 4::
		SendInput ^!4
		return
	CapsLock & 5::
		SendInput ^!5
		return
	CapsLock & 6::
		SendInput ^!6
		return
	CapsLock & 7::
		SendInput ^!0
		return
	^t::
		return
	}
#IfWinActive


; ------------------------------------
; SCRIPT ACTIONS
; ------------------------------------

#!r::Reload
#!e::Edit

#!x::
Suspend, On
Pause, On
Return

#!z::
Suspend, Off
Pause, Off
Return