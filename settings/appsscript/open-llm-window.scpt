(*
tell application "ghostty"
    activate
    tell application "System Events"
        click menu item "New Tab" of menu 1 of menu bar item "File" of menu bar 1 of process "ghostty"
        keystroke "m" using {control down, command down, option down, shift down}
    end tell
end tell
*)

tell application "GoLand"
    activate
    tell application "System Events"
        key code 53 -- Escape
        keystroke ":action NewScratchFile"
        keystroke return
        keystroke return
        delay 0.00001
        keystroke return
        delay 0.02
        keystroke "i"
    end tell
end tell
