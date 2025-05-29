#Requires AutoHotkey v2.0


; For documentation about the parameters, refer to:
;  https://learn.microsoft.com/en-us/windows/win32/shell/shell-shellexecute
ShellRun(filePath, arguments?, directory?, operation?, show?) {
    static VT_UI4 := 0x13, SWC_DESKTOP := ComValue(VT_UI4, 0x8)
    ComObject("Shell.Application").Windows.Item(SWC_DESKTOP).Document.Application
        .ShellExecute(filePath, arguments?, directory?, operation?, show?)
}

;@Ahk2Exe-ExeName launcher
;@Ahk2Exe-SetMainIcon wt_101.ico

#NoTrayIcon

path := ""
admin := ""

loop A_Args.Length {
    arg := A_Args[A_Index]
    if (arg = "-a") {
        admin := true
        continue
    }
    
    if (arg = "-p" && A_Index < A_Args.Length) {
        path := StrReplace(A_Args[A_Index + 1], "\`"", "\\`"")
        A_Index++
    }
}

arguments := path ? "-d " . path : ""
operation := admin ? "runas" : ""
ShellRun(
    EnvGet("LOCALAPPDATA") . "\Microsoft\WindowsApps\wt.exe",
    arguments,
    ,
    operation,
    1
)
