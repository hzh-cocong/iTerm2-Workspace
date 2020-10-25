-- function: save data to the file
on write_to_file(this_data, target_file, append_data) -- (string, file path as string, boolean)
    try
        set the target_file to the target_file as text
        set the open_target_file to open for access file target_file with write permission
        if append_data is false then  set eof of the open_target_file to 0
        write this_data to the open_target_file starting at eof
        close access the open_target_file
        return true
    on error
        try
            close access file target_file
        end try
        return false
    end try
end write_to_file

------------------------------------------------
------------------------------------------------

set dirs to {}

-- get the window path
tell application "iTerm"
    tell current window
        set i to 1
        set _tabs to tabs
        set len to the length of _tabs
        repeat with _tab in tabs
            tell current session of _tab
                set _path to (variable named "session.path")
                if i < len then
                    set dirs to dirs & { _path }
                end if
            end tell
            set i to i + 1
        end repeat
    end tell
end tell

-- -- process path
set string_dirs to ""
set i to 1
repeat with dir in dirs
    if i = 1 then
        set string_dirs to "\"" & dir & "\""
    else
        set string_dirs to string_dirs & "," & "\"" & dir & "\""
    end if

    set i to i + 1
end repeat

-- generate code
set code to "
set dirs to { " & string_dirs & " }

tell application \"iTerm\"
    set _window to (create window with default profile)
    tell _window
        set len to the length of dirs
        repeat with i from 1 to len
            set dir to item i of dirs
            tell current session of current tab
                write text \"cd \" & \"\\\"\" & dir & \"\\\"\"
            end tell
            if i < len
                create tab with default profile
            end if
        end repeat
    end tell
end tell
"

-- choose file name
set _prompt to "SaveTabs"
choose file name with prompt _prompt default name "" default location file "Macintosh HD:Users:hzh:Downloads"
set _path to the result
set _path to _path & ".iTerm2.applescript"

-- save code to the file
write_to_file(code, _path, false)