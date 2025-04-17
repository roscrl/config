tell application "ghostty"
    activate
    tell application "System Events"
        keystroke "c"
        keystroke " "
        keystroke "s" using {command down}
        keystroke return
    end tell
end tell
