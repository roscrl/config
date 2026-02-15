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
