; Thesaurus
; Fanatic Guru
; 2016 03 15
; Version: 1.0
;
; Thesaurus Search at Thesaurus.com
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
W := 700
H := 400
Style =
(
<style>
ul {
	padding: 1em;
	margin: -1em 0em 0em 2em;
	float: left;
}

.heading-row {
	clear: left;
}

H2 {
	margin: .1em 0em .1em 0em;
}

.header-antonyms {
	margin: -.3em 0em 0em 0em;
	font-size: 1.25em;
}

.synonym-description {
	border-top: 1px solid black;
	border-bottom: 1px solid black;
}

.synonyms-horizontal-divider {
	position: relative;
	top: -3.1em;
	border-top: 1px solid black;
	border-bottom: 2px solid black;
}
</style>
)

;}

; INITIALIZATION - GUI
;{-----------------------------------------------
;
Gui +LabelThesaurusGui
Gui, Margin, 0, 0
Gui, +Resize +MinSize700x400
Gui, Font, s18 Bold, Verdana
Gui, Add, Edit, 0x8 0x1 -VScroll r2 x0 y0 w%W% vBanner gBanner_Enter hwndBannerControl
GuiControl, Move, Banner, h38
Gui, Add, ActiveX, x0 y38 w%W% h%H% vDisplay hwndHtmlControl, HTMLFile
ComObjConnect(Display, "Doc_")
oHTML := ComObjCreate("HTMLfile")
oHTML.write("<div>Initilize</div>")
;}

; HOTKEYS
;{-----------------------------------------------
;
!t::	;<-- Thesaurus Search Using Highlighted Text
	Hotkey_Start:
	Save_Clipboard := ClipboardAll
	Clipboard := ""
	Send ^c
	ClipWait, .5
	Word := Clipboard
	Clipboard := Save_Clipboard
	Save_Clipboard := ""
	Display.body.innerHTML := ""
	Banner_Input:
	if Word
	{
		Word := RegExReplace(Word, "[^\w\s]")
		HT := ++HP
		If (HT - HB > HM)
			History[HB] := "", HB ++
		
		oHTML.body.innerHTML := Get_Html("http://thesaurus.com/browse/" Word)
		oHTML.body.innerHTML := GetNodesByClassName(oHTML,"synonyms_wrapper")[1].outerHTML Style
		StripElements(oHTML, "A")
		RemoveNodesByClassName(oHTML
		, "citation"
		, "star inactive"
		, "tabset"
		, "form-block"
		, "synonyms-heading"
		, "misspell-bottom")
		oHTML.body.innerHTML := RegExReplace(RegExReplace(oHTML.body.innerHTML,"U)<H2>Antonyms.*</H2>", "<H2 class=header-antonyms>Antonyms</H2>"), "U)<H2>Synonyms.*</H2>", "<H2>Synonyms</H2>")
		Display.body.innerHTML := oHTML.body.innerHTML
		History[HP,"Body"] := Display.body.innerHTML
		History[HP,"Word"] := Word
	}
	Display:
	GuiControl,, Banner, %Word%
	if Word
		GuiControl, Focus, Display
	else
		GuiControl, Focus, Banner
	Display.selection.empty()
	Display.parentWindow.scrollTo(0,0)
	Gui, Show
return

#ifWinActive, Thesaurus.ahk ahk_class AutoHotkeyGUI
Left::		;<-- History Back
	if (HP > HB)
	{
		--HP
		Display.body.innerHTML := History[HP,"Body"]
		Word := History[HP,"Word"]
		gosub Display
	}
return

Right::		;<-- History Forward
	if (HP < HT)
	{
		++HP
		Display.body.innerHTML := History[HP,"Body"]
		Word := History[HP,"Word"]
		gosub Display
	}
return
;}

; SUBROUTINES - GUI
;{-----------------------------------------------
;
ThesaurusGuiSize:
	GuiControl, Move, %HtmlControl%, % "W" A_GuiWidth " H" A_GuiHeight-36
	GuiControl, Move, %BannerControl%, % "W" A_GuiWidth  
return

ThesaurusGuiClose:
ThesaurusGuiEscape:
	Gui Show, Hide
	HP := HT
return

Banner_Enter:
	Gui, Submit, NoHide
	if Banner contains `n
	{
		Word := Trim(Banner, " `t`n")
		gosub Banner_Input
	}
	return
;}

; FUNCTIONS
;{-----------------------------------------------
;
Get_HTML(Http)
{
	if !whr
		whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
	whr.Open("GET", Http, true)
	whr.Send()
	whr.WaitForResponse()
	return whr.ResponseText
}

GetNodesByClassName(ByRef Doc, Names*)
{
	Nodes := {}
	for index, Name in Names
		Needle .= Name "|"
	Needle := "i)\b" SubStr(Needle,1,-1) "\b"
	list := Doc.getElementsByTagName("*")
	Count := list.length
	loop %Count%
		if (child := list[A_Index-1])
			if (child.className ~= Needle)
				Nodes.Push(child)
	return Nodes
}

RemoveNodesByClassName(ByRef Doc, Names*)
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

StripElements(ByRef Doc, Elements*)
{
	for index, Element in Elements
	{
		list := Doc.getElementsByTagName(Element)
		Count := list.length
		loop %Count%
			list[Count-A_Index].outerHTML := list[Count-A_Index].innerHTML
	}
	return Count
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
