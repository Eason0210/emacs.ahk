;;
;; An autohotkey script that provides emacs-like keybinding on Windows
;;
InstallKeybdHook
#UseHook

; The following line is a contribution of NTEmacs wiki http://www49.atwiki.jp/ntemacs/pages/20.html
SetKeyDelay 0

; turns to be 1 when ctrl-x is pressed
global IS_PRE_X := 0
; turns to be 1 when ctrl-space is pressed
global IS_PRE_SPC := 0
; turns to be 1 when Ctrl-c is pressed
global IS_PRE_C := 0

; Applications you want to disable emacs-like keybindings
; (Please comment out applications you don't use)
is_target()
{
if WinActive("ahk_class ConsoleWindowClass") ; Cygwin
    return 1
if WinActive("ahk_exe Code.exe") ;vscode
    return 1
; if WinActive("ahk_exe devenv.exe") ; Visual Studio 2022
;     return 1
if WinActive("ahk_class VMwareUnityHostWndClass") ; Avoid VMwareUnity with AutoHotkey
    return 1
if WinActive("ahk_class mintty")
    return 1
if WinActive("ahk_class Window Class")
    return 1
if WinActive("ahk_class CASCADIA_HOSTING_WINDOW_CLASS") ;Windows 10 terminal
    return 1
if WinActive("ahk_class Vim") ; GVI
    return 1
if WinActive("ahk_class Emacs") ; NTEmacs
    return 1
if WinActive("ahk_class X410_XAppWin")
    return 1
if WinActive("ahk_class RAIL_WINDOW")
    return 1
return 0
}

is_smatraPDF()
{
if WinActive("ahk_class SUMATRA_PDF_FRAME") ; smatraPDF
    return 1
return 0
}

delete_char()
{
    Send "{Del}"
    global IS_PRE_SPC := 0
}

delete_word()
{
    Send "^{Del}"
    global IS_PRE_SPC := 0
}

delete_backward_char()
{
    Send "{BS}"
    global IS_PRE_SPC := 0
}
kill_line()
{
    Send "{ShiftDown}{END}{SHIFTUP}"
    Sleep 50 ;[ms] this value depends on your environment
    Send "^x"
    global IS_PRE_SPC := 0
}
open_line()
{
    Send "{END}{Enter}{Up}"
    global IS_PRE_SPC := 0
}

open_line_emacs()
{
    Send "{Home}{Enter}{Up}"
    global IS_PRE_SPC := 0
}
quit()
{
    Send "{ESC}"
    global IS_PRE_SPC := 0
}
newline()
{
    Send "{Enter}"
    global IS_PRE_SPC := 0
}

duplicate_line()
{
    Send "^d"
    global IS_PRE_SPC := 0
}

newline_emacs()
{
    Send "{END}{Enter}"
    global IS_PRE_SPC := 0
}
indent_for_tab_command()
{
    Send "{Tab}"
    global IS_PRE_SPC := 0
}

indent_for_tab_command_invert()
{
    Send "+{Tab}"
    global IS_PRE_SPC := 0
}
newline_and_indent()
{
    Send "{Enter}{Tab}"
    global IS_PRE_SPC := 0
}
isearch_forward()
{
    Send "^f"
    global IS_PRE_SPC := 0
}
isearch_backward()
{
    Send "^f"
    global IS_PRE_SPC := 0
}
kill_region()
{
    Send "^x"
    global IS_PRE_SPC := 0
}
kill_ring_save()
{
    Send "^c"
    global IS_PRE_SPC := 0
}
yank()
{
    Send "^v"
    global IS_PRE_SPC := 0
}
undo()
{
    Send "^z"
    global IS_PRE_SPC := 0
}

redo()
{
    Send "^y"
    global IS_PRE_SPC := 0
}
find_file()
{
    Send "^o"
    global IS_PRE_X := 0
}
save_buffer()
{
    Send "^s"
    global IS_PRE_X := 0
}
kill_emacs()
{
    Send "!{F4}"
    global IS_PRE_X := 0
}

move_beginning_of_line()
{
    global
    if IS_PRE_SPC
        Send "+{HOME}"
    else
        Send "{HOME}"
}
move_end_of_line()
{
    global
    if IS_PRE_SPC
        Send "+{END}"
    else
        Send "{END}"
}
previous_line()
{
    global
    if IS_PRE_SPC
        Send "+{Up}"
    else
        Send "{Up}"
}
next_line()
{
    global
    if IS_PRE_SPC
        Send "+{Down}"
    else
        Send "{Down}"
}
forward_char()
{
    global
    if IS_PRE_SPC
        Send "+{Right}"
    else
        Send "{Right}"
}
backward_char()
{
    global
    if IS_PRE_SPC
        Send "+{Left}"
    else
        Send "{Left}"
}

forward_word()
{
    global
    if IS_PRE_SPC
        Send "^+{Right}"
    else
        Send "^{Right}"
}

backward_word()
{
    global
    if IS_PRE_SPC
        Send "^+{Left}"
    else
        Send "^{Left}"
}

scroll_up()
{
    global
    if IS_PRE_SPC
        Send "+{PgUp}"
    else
        Send "{PgUp}"
}
scroll_down()
{
    global
    if IS_PRE_SPC
        Send "+{PgDn}"
    else
        Send "{PgDn}"
}

mark_whole_buffer()
{
    Send "^{End}^+{Home}"
    global IS_PRE_SPC := 0
}


^x::
{
if is_target()
    Send(A_ThisHotkey)
else
    global IS_PRE_X := 1
}
^f::
{
if is_target()
    Send(A_ThisHotkey)
else
{
    if IS_PRE_X
        find_file()
    else
        forward_char()
}
}
!f::
{
if is_target()
    Send(A_ThisHotkey)
else
    forward_word()
}
!b::
{
if is_target()
    Send(A_ThisHotkey)
else
    backward_word()
}

^c::
{
if is_target()
    Send(A_ThisHotkey)
else
{
    if IS_PRE_X
        kill_emacs()
    else
        global IS_PRE_C := 1
}
}
^d::
{
if is_target()
    Send(A_ThisHotkey)
else
{
    if is_smatraPDF()
        Send "^b"
    else
        delete_char()
}
}
!d::
{
if is_target()
    Send(A_ThisHotkey)
else
    delete_word()
}
^h::
{
if is_target()
    Send(A_ThisHotkey)
else
    delete_backward_char()
}
^k::
{
if is_target()
    Send(A_ThisHotkey)
else
    kill_line()
}
^o::
{
if is_target()
    Send(A_ThisHotkey)
else
    open_line_emacs()
}
^g::
{
if is_target()
    Send(A_ThisHotkey)
else
    quit()
}
^l::
{
if (is_target() || is_smatraPDF())
    Send(A_ThisHotkey)
else
    newline_emacs()
}
^j::
{
if is_target()
    Send(A_ThisHotkey)
else
    newline_and_indent()
}
^m::
{
if is_target()
    Send(A_ThisHotkey)
else
    newline()
}
^i::
{
if is_target()
    Send(A_ThisHotkey)
else
    indent_for_tab_command_invert()
}
!i::
{
if is_target()
    Send(A_ThisHotkey)
else
    indent_for_tab_command()
}
^s::
{
if is_target()
    Send(A_ThisHotkey)
else
{
    if IS_PRE_X
        save_buffer()
    else
        isearch_forward()
}
}
^r::
{
if is_target()
    Send(A_ThisHotkey)
else
    isearch_backward()
}
^w::
{
if (is_target() || is_smatraPDF())
    Send(A_ThisHotkey)
else
    kill_region()
}
!w::
{
if is_target()
    Send(A_ThisHotkey)
else
    kill_ring_save()
}
^y::
{
if is_target()
    Send(A_ThisHotkey)
else
    yank()
}
^/::
{
if is_target()
    Send(A_ThisHotkey)
else
    undo()
}
^+/::
{
if is_target()
    Send(A_ThisHotkey)
else
    redo()
}
;; Set the mark with C-SPC in Emacs
^Space::
{
if WinActive("ahk_class Emacs") or WinActive("ahk_class  X410_XAppWin")
    Send "^{@}"
else
{
if is_target()
    Send "{CtrlDown}{Space}{CtrlUp}"
else
{
    if IS_PRE_SPC
        global IS_PRE_SPC := 0
    else
        global IS_PRE_SPC := 1
}
}
}

!h::
{
if is_target()
    Send(A_ThisHotkey)
else
{
    if IS_PRE_SPC
        global IS_PRE_SPC := 0
    else
        global IS_PRE_SPC := 1
}
}
^a::
{
if is_target()
    Send(A_ThisHotkey)
else
    move_beginning_of_line()
}
^e::
{
if is_target()
    Send(A_ThisHotkey)
else
    move_end_of_line()
}
^p::
{
if is_target()
    Send(A_ThisHotkey)
else
    previous_line()
}
^n::
{
if is_target()
    Send(A_ThisHotkey)
else
    next_line()
}
^b::
{
if is_target()
    Send(A_ThisHotkey)
else
    backward_char()
}
^v::
{
if is_target()
    Send(A_ThisHotkey)
else
    scroll_down()
}
!v::
{
if is_target()
    Send(A_ThisHotkey)
else
    scroll_up()
}
;;text scale increase
#=::
{
if is_target()
    Send(A_ThisHotkey)
else
    Send "^{WheelUp}"
}
;;text scale decrease
#-::
{
if is_target()
    Send(A_ThisHotkey)
else
    Send "^{WheelDown}"
}
;; maximize and restore window
#f::
{
WinGetPos &X, &Y,,, "A"
if  X < -5
    WinRestore("A")
else
    WinMaximize("A")
}
h::
{
if is_target()
    Send(A_ThisHotkey)
else
{
    if IS_PRE_X
    {
        mark_whole_buffer()
        global IS_PRE_X := 0
    }
    else
        Send(A_ThisHotkey)
}
}
d::
{
if is_target()
    Send(A_ThisHotkey)
else
{
    if IS_PRE_C
    {
        duplicate_line()
        next_line()
        global IS_PRE_C := 0
    }
    else
        Send(A_ThisHotkey)
}
}
;; For Visual Studio
;; Goto Ducument M-.
!.::
{
if is_target()
    Send(A_ThisHotkey)
else
    Send "{F12}"
}
;; Back to last location M-,
!,::
{
if is_target()
    Send(A_ThisHotkey)
else
    Send "^{-}"
}

;; Toggle Chinese and English input method in Emacs

$CapsLock::
{
global
	SetStoreCapsLockMode(false)
	ErrorLevel := !KeyWait("CapsLock", "T0.25")
	if ErrorLevel
		Send("{CapsLock}") ;; Long press
	else
		{
		ErrorLevel := !KeyWait("CapsLock", "D T0.5")
		if ErrorLevel      ;; Single click
		{
			If WinActive("ahk_exe emacs.exe")
			   Send ("{f9}")
			else
			   Send ("{RShift}")
			   
			   
				
		}
		else               ;; Double click
			Send("{CapsLock}")
		}
	ErrorLevel := !KeyWait("CapsLock")
return
}

;; #HotIf WinActive("ahk_exe emacs.exe")
;; CapsLock::Send "{f9}"

;; #HotIf
;; CapsLock::RShift

;; f12::CapsLock

;; Bind Tab and Shift+Tab to Up and Down in PolyWorks
#HotIf WinActive("ahk_exe iminspect.exe") or WinActive("ahk_exe polyworks.exe") or WinActive("ahk_exe imedit.exe")
Tab::Send "{Down}"
+Tab::Send "{Blind}{Up}"
#HotIf

#HotIf WinActive("ahk_exe devenv.exe")
Tab::Send "{Down}"
+Tab::Send "{Up}"
;;^Space::Send "^{@}"

;; Toggle line comment C-x,C-;
^;::
{
if is_target()
    Send(A_ThisHotkey)
else
{
    if IS_PRE_X
    {
        Send "^{k}"
        Sleep 50
        Send "^{/}"
        ; next_line()
        global IS_PRE_X := 0
    }
    else
        Send(A_ThisHotkey)
}
}

f::
{
if is_target()
    Send(A_ThisHotkey)
else
{
    if IS_PRE_C
    {
        Send "^{k}"
        Sleep 50
        Send "^{d}"   
        global IS_PRE_C := 0
    }
    else
        Send(A_ThisHotkey)
}
}

#HotIf
