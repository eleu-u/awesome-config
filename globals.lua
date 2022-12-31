function quick_notify(title_a, text_a)
    naughty.notify({preset = naughty.config.presets.normal, title = title_a, text = text_a})
end

function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

function minimize_all_windows()
    for _, c in ipairs(client.get()) do
        c.minimized = true
    end
end

-- This is used later as the default terminal and editor to run.
terminal = "kitty"
editor = os.getenv("EDITOR") or "editor"
editor_cmd = terminal .. " -e " .. editor

modkey = "Mod4"

menubar.utils.terminal = terminal