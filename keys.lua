-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({}, 3, function() 
        mymainmenu:toggle() 
    end),

    awful.button({}, 4, awful.tag.viewnext),
    awful.button({}, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(
    awful.key({modkey}, "Up", awful.tag.viewprev),
    awful.key({modkey}, "Down", awful.tag.viewnext),
    
    awful.key({modkey}, "Escape", awful.tag.history.restore),

    awful.key({modkey}, "Right", function()
        awful.client.focus.byidx(1)
    end),

    awful.key({modkey}, "Left", function()
        awful.client.focus.byidx(-1)
    end),

    -- Layout manipulation
    awful.key({modkey, "Shift"}, "Right", function() 
        awful.client.swap.byidx(1) 
    end),

    awful.key({modkey, "Shift"}, "Left", function() 
        awful.client.swap.byidx( -1)    
    end),
    
    awful.key({modkey}, "u", awful.client.urgent.jumpto),

    awful.key({"Mod1"}, "Tab", function()
        awful.client.focus.history.previous()
        if client.focus then
            client.focus:raise()
        end
    end),

    -- Standard program
    awful.key({modkey}, "t", function() 
    	awful.spawn(terminal) 
    end),
    
    -- reload awesome
    awful.key({modkey, "Control"}, "r", awesome.restart),

    -- emulate awesome with xephyr 
    awful.key({modkey, "Mod1"}, "r", function()
        awful.spawn.with_shell("Xephyr :5 & sleep 1 ; DISPLAY=:5 awesome") 
    end),

    awful.key({modkey}, "l", function() 
        awful.tag.incmwfact(0.05)          
    end),
    
    awful.key({modkey}, "h", function() 
        awful.tag.incmwfact(-0.05) 
    end),

    awful.key({modkey, "Shift"}, "h", function() 
        awful.tag.incnmaster(1, nil, true) 
    end),

    awful.key({modkey, "Shift"}, "l", function() 
        awful.tag.incnmaster(-1, nil, true) 
    end),

    awful.key({modkey, "Control"}, "h", function() 
        awful.tag.incncol(1, nil, true)  
    end),

    awful.key({modkey, "Control"}, "l", function() 
        awful.tag.incncol(-1, nil, true) 
    end),

    awful.key({modkey}, "space", function() 
        awful.layout.inc(1) 
    end),

    awful.key({modkey, "Shift"}, "space", function() 
        awful.layout.inc(-1) 
    end),

    awful.key({modkey, "Control"}, "n", function()
        local c = awful.client.restore()
        -- Focus restored client
        if c then
            c:emit_signal("request::activate", "key.unminimize", {raise = true})
        end
    end),

    -- Prompt
    awful.key({modkey}, "s", function() 
        menubar.show()
    end),

    awful.key({modkey}, "r", function() 
    	awful.util.spawn("dmenu_run")
    end),

    awful.key({modkey}, "x", function()
        awful.prompt.run {
            prompt = "Run Lua code: ",
            textbox = awful.screen.focused().mypromptbox.widget,
            exe_callback = awful.util.eval,
            history_path = awful.util.get_cache_dir() .. "/history_eval"
        }
    end),

    -- MY STUFF !!! :D

    awful.key({}, "Print", function()
        awful.spawn.with_shell("scrot $HOME/Pictures/screenshots/screenshot.png -s --freeze -e 'xclip -selection clipboard -t image/png -i $f'")
    end),

    awful.key({modkey}, "d", minimize_all_windows)
)

clientkeys = gears.table.join(
    awful.key({modkey}, "f", function(c)
        c.fullscreen = not c.fullscreen
        c:raise()
    end),

    awful.key({modkey}, "c", function (c) 
        c:kill() 
    end),

    awful.key({modkey, "Control"}, "space", awful.client.floating.toggle),

    awful.key({modkey, "Control"}, "Return", function (c) c
        :swap(awful.client.getmaster()) 
    end),

    awful.key({modkey}, "o", function (c) 
        c:move_to_screen() 
    end),

    awful.key({modkey}, "t", function (c) 
        c.ontop = not c.ontop            
    end),

    awful.key({modkey}, "n", function(c)
        -- The client currently has the input focus, so it cannot be
        -- minimized, since minimized clients can't have the focus.
        c.minimized = true
    end),

    awful.key({modkey}, "m", function(c)
        c.maximized = not c.maximized
        c:raise()
    end),

    awful.key({modkey, "Control"}, "m", function (c)
        c.maximized_vertical = not c.maximized_vertical
        c:raise()
    end),

    awful.key({modkey, "Shift"}, "m", function(c)
        c.maximized_horizontal = not c.maximized_horizontal
        c:raise()
    end)
)

root.keys(globalkeys)