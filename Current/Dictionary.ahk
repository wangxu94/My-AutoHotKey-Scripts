; Dictionary
; Fanatic Guru
; 2016 03 10
; Version: 1.21
;
; Dictionary Search at Dictionary.com
;
;{-----------------------------------------------
; Downloads http text from website and trim it down and format for display in ActiveX Gui
;}

; INITIALIZATION - ENVIROMENT
;{-----------------------------------------------
;
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance force  ; Ensures that only the last executed instance of script is running
SetControlDelay -1 
;}

; INITIALIZATION - VARIABLES
;{-----------------------------------------------
;
History := {}
HP := 0
HB := 1
HM := 15 ; Maximum Word History
W := Floor(A_ScreenWidth / 3)
H := Floor(A_ScreenHeight / 3)
;}

; INITIALIZATION - GUI
;{-----------------------------------------------
;
Gui +LabelDictionaryGui
Gui, Margin, 0, 0
Gui, +Resize
Gui, Add, ActiveX, w%W% h%H% vDisplay hwndHtmlControl, HTMLFile
ComObjConnect(Display, "Doc_")
;}

; HOTKEYS
;{-----------------------------------------------
;
^!d::	;<-- Dictionary Search Using Highlighted Text
	Hotkey_Start:
	Word := ""
	Save_Clipboard := ClipboardAll
	Clipboard := ""
	Send ^c
	ClipWait, .5
	Word := Clipboard
	Clipboard := Save_Clipboard
	Save_Clipboard := ""
	if !Word
	{
		InputBox Word, Define Word, Enter word to define., , 200, 120
		if (ErrorLevel or !Word)
			return
	}
	HT := ++HP
	If (HT - HB > HM)
		History[HB] := "", HB ++
	Display.body.innerHTML := Get_Definition_Html(RegExReplace(Word, "[^\w\s]"))
	RemoveNodeByClassName(Display
	, "ipapron" 
	, "headword-bar-list" 
	, "pronounce-button"
	, "syllable-button"
	, "button-source"
	, "tail-wrapper"
	, "video-content"
	, "audio-wrapper"
	, "deep-link-synonyms")
	History[HP] := Display.body.innerHTML
	Display:
	Display.selection.empty()
	Display.parentWindow.scrollTo(0,0)
	Gui, Show
return

#ifWinActive, Dictionary.ahk ahk_class AutoHotkeyGUI
Left::		;<-- History Back
	if (HP > HB)
	{
		Display.body.innerHTML := History[--HP]
		gosub Display
	}
return

Right::		;<-- History Forward
	if (HP < HT)
	{
		Display.body.innerHTML := History[++HP]
		gosub Display
	}
return
;}

; SUBROUTINES - GUI
;{-----------------------------------------------
;
DictionaryGuiSize:
	GuiControl, Move, %HtmlControl%, W%A_GuiWidth% H%A_GuiHeight%
return

DictionaryGuiClose:
DictionaryGuiEscape:
	Gui Show, Hide
	HP := HT
return
;}

; FUNCTIONS
;{-----------------------------------------------
;
Get_Definition_Html(Word)
{
	if !whr
		whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
	whr.Open("GET", "http://dictionary.reference.com/browse/" Word "+?s=t", true)
	whr.Send()
	whr.WaitForResponse()
	Http_Text := whr.ResponseText
	if RegExMatch(Http_Text, "sU)Did you mean <a href=.*<span class=""me"" .*>(.*)</span>",Match)
		return "<font size=""4em"">Did you mean </font><font size=""6em""><b>" Match1 "</b>?</font>"
	if RegExMatch(Http_Text,"sU)(<div class=""center-well-container"".*)<div class=""source-meta"">", Section)
		Section := Section1
	else
		return "<h1>" Word "</h1><h2>NO results found on Dictionary.com</h2>"
	Section := RegExReplace(Section, "\(<span class=""prontoggle pronounce-inline"">Show IPA</span>\)")
	Section := RegExReplace(Section, "sU)<a [^>]*href=[^>]*>(.*)</a>","$1")
	Section := RegExReplace(Section, "sU)<header class=""luna-data-header"">(.*)</header>","<h3 style=""margin-top: .5em; margin-bottom: 0em; text-decoration: underline;"">$1</h3>")
	Section := RegExReplace(Section, "sU)<div class=""def-block def-inline-example"">(.*)</div>","$1")

	Section =
	(
	%Section%
	<style>
	.head-entry {margin-bottom: 0em; font-size: 2em;}
	.dbox-example {color:gray;}
	.dbox-italic {font-style:italic;}
	.dbox-bold {font-weight:bold;}
	.def-sub-list {margin: -.1em 0em .5em 2em; list-style-type: lower-alpha}
	.def-content {margin: -1.1em 0em 0em 2em;}
	.def-block-label-synonyms {margin-left: 1em;}
	</style>
	)
	return Section
}

RemoveNodeByClassName(ByRef Doc, Names*)
{
	for index, Name in Names
		Needle .= Name "|"
	Needle := "i)\b" SubStr(Needle,1,-1) "\b"
	list := Doc.getElementsByTagName("*")
	Count := list.length
	loop %Count%
		if (child := list[Count-A_Index])
			if (child.className ~= Needle)
				child.parentNode.removeChild(child)
	return
}
;}

; FUNCTIONS - GUI
;{-----------------------------------------------
;
Doc_OnKeyPress(Doc)
{
    static keys := {1:"selectall", 3:"copy", 22:"paste", 24:"cut"}
    keyCode := Doc.parentWindow.event.keyCode
	If keys.HasKey(keyCode)
		Doc.ExecCommand(keys[keyCode])
}

Doc_OnDblClick() 
{
	gosub Hotkey_Start
}
;}
