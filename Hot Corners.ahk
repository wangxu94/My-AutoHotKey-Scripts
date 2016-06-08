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
	