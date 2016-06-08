# My-AutoHotKey-Scripts

AutoHotKey scripts for my personal use

"Current" directory contains the latest scripts in current use
## MyHotKeys.ahk


### Hot Corners
Credit to https://www.reddit.com/r/Windows10/comments/3ivdvu/how_could_i_activate_task_view_with_a_hot_corner/cynfido

Toggle Windows 10 Task View when mouse to top left corner


### Vim navigation
Credit to https://github.com/jongbinjung/ahk-vim-navigation with some changes of my own
#### Commands

##### Regular movements
Activated by holding CapsLock

hjkl: cursor movements

w: move to next word

b: move to previous word

0: go to beginning of line

-: go to end of line (this is just how I use it personally in VIM)

$: go to end of line (for general compatibility... :D)

##### Editing Commands
y: Copy

d: Cut

p: Paste

u: undo (Ctrl+z)

/: Search (Ctrl+f)


### Google
Credit to Fanatic Guru on this thread: https://autohotkey.com/board/topic/115094-simple-google-search-script-need-help/

Search highlighted text on Google with Ctrl-g
#### Functions
Google Search: Ctrl + g

Google Images: Ctrl + Shift + g

Google Maps: Ctrl + Alt + g


### Launch Multi Commmander with Win E
Launch Multi Commmander with Win + E


### Switch Virtual Desktops
Credit to https://github.com/pmb6tz/windows-desktop-switcher

Hotkey changed to Alt to accommodate the vim bindings on CapsLock

#### Functions
Switch to virtual desktop on the left: Alt + j / Alt + MouseWheelUp

Switch to virtual desktop on the right: Alt + k / Alt + MouseWheelDown

Switch to virtual desktop <Num>: Alt + <Num>

Create virtual desktop: Alt + c

Destroy virtual desktop: Alt + x


### Microsoft Word

#### Zotero add citation
Add citation from Zotero with CapsLock + c

##### Requirements
Map Zotero add citation function to Ctrl + Shift + y as shown here: https://diyivorytower.wordpress.com/2012/03/06/create-zotero-hotkeys-in-word/


### Word Count
Credit to BrunoMP on this thread: https://autohotkey.com/board/topic/43584-help-with-word-count/

CapsLock + E to show word count of selected text


### Switch Tabs
Switch to tab on the left: Ctrl + J / Ctrl + MouseWheelUp

Switch to tab on the right: Ctrl + K / Ctrl + MouseWheelDown


### Switch/Minimise window
Minimise active window: CapsLock + `

Alt-Tab: ` / RButton + LButton


### Show context menu
Show context menu with CapsLock + r


### Monitor Off

#### Requirements
nircmd

http://www.nirsoft.net/utils/nircmd.html


### Script Actions
Reload script: Win + Alt + r

Suspend and Pause script: Win + Alt + x

Resumme script: Win + Alt + z


## AutoCorrect.ahk
Based on http://www.autohotkey.com/download/AutoCorrect.ahk with some additions

### Functions
Win + h: Add correction

Win + Alt + h: Reload script

Win + Alt + s Suspend script

### Added corrections
Capitalise common names

Capitalise country names

Correct US to UK spellings