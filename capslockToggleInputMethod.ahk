;;使用Capslock切换中/英文，长按Capslock锁定/解锁大小写
SetStoreCapslockMode, Off
Capslock::
	KeyWait, CapsLock
	If (A_TimeSinceThisHotkey > 200)
		SetTimer, mainp, -1
	Else
	{
	 state := GetKeyState("CapsLock", "T") ; True if CapsLock is ON, false otherwise.
     If state
     {
        SetCapsLockState % !GetKeyState("CapsLock", "T")
     }
	 Else
	 {
	   IfWinActive,ahk_class Emacs ; NTEmacs
	     Send ^{\}
	   Else
		 Send #{Space}
	 }
	}
Return

mainp:
    SetCapsLockState % !GetKeyState("CapsLock", "T") ; requires [v1.1.30+]
Return
