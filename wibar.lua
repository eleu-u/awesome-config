awful.layout.layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
    awful.button({}, 1, function(t) 
        t:view_only() 
    end),

    awful.button({modkey}, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),

    awful.button({}, 3, awful.tag.viewtoggle),

    awful.button({modkey}, 3, function(t)
        if client.focus then
            client.focus:toggle_tag(t)
        end
    end),

    awful.button({}, 4, function(t) 
        awful.tag.viewnext(t.screen) 
    end),

    awful.button({}, 5, function(t) 
        awful.tag.viewprev(t.screen) 
    end)
)

local tasklist_buttons = gears.table.join(
    awful.button({}, 1, function (c)
        if c == client.focus then
            c.minimized = true
        else
            c:emit_signal(
                "request::activate",
                "tasklist",
                {raise = true}
            )
        end
    end),

    awful.button({}, 3, function()
        awful.menu.client_list({theme = { width = 250 }})
    end),

    -- scroll to change windows
    awful.button({}, 4, function()
        awful.client.focus.byidx(1)
    end),

    awful.button({}, 5, function()
        awful.client.focus.byidx(-1)
    end)
)
-- widgets setup!!

local hide_desktop_button = wibox.widget.textbox(" ")
hide_desktop_button:connect_signal("button::press", function(the, docummentation, is_outdated, button)
    if button == 1 then
        minimize_all_windows()
    end
end)

local text_clock = wibox.widget.textclock(" %d/%m/%y %I:%M %p ", 1)
local month_calendar = awful.widget.calendar_popup.month({long_weekdays = true})
month_calendar:attach(text_clock, "br")

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    awful.tag({"1", "2", "3", "4", "5", "6", "7", "8", "9"}, s, awful.layout.layouts[1])

    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mypromptbox = awful.widget.prompt() -- this is used for later by Super+X (lua interpreter)
    s.mylayoutbox = awful.widget.layoutbox(s)

    s.mylayoutbox:buttons(gears.table.join(
        awful.button({}, 1, function () awful.layout.inc( 1) end),
        awful.button({}, 3, function () awful.layout.inc(-1) end),
        awful.button({}, 4, function () awful.layout.inc( 1) end),
        awful.button({}, 5, function () awful.layout.inc(-1) end))
    )

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
    }

    -- Create the wibox
    s.mywibox = awful.wibar({position = "bottom", screen = s})

    -- TASKLIST PANEL
    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            mylauncher,
            wibox.widget.textbox(" "),
            s.mypromptbox,
        },
        --{ -- Middle widget
            -- this makes the elements fixed with
            --layout = wibox.layout.fixed.horizontal, 
            --expand = "inside",
            s.mytasklist,
        --},
        { -- Right widgets
            wibox.widget.textbox(" "),
            layout = wibox.layout.fixed.horizontal,
            awful.widget.keyboardlayout(),
            wibox.widget.systray(),
            text_clock,
            s.mylayoutbox,
            hide_desktop_button
        },
    }

    s.desktop_icons = wibox {
        visible = true,
        width = 64,
        height = 64,
        bg = "#ffffff0",
        opacity = 1,
        below = true,
    }
    
    s.desktop_icons:setup {
        layout = wibox.layout.fixed.vertical,
        widget = wibox.container.place,
        {
            layout = wibox.layout.fixed.vertical,
            wibox.widget {
                image  = beautiful.awesome_icon,
                resize = true,
                forced_height = 16,
                forced_width  = 16,
                halign = "right",
                widget = wibox.widget.imagebox
            },
            wibox.widget.textbox("home"),
        },
        wibox.widget.textbox(" "),
        {
            layout = wibox.layout.fixed.vertical,
            wibox.widget {
                image  = beautiful.awesome_icon,
                resize = true,
                forced_height = 16,
                forced_width  = 16,
                halign = "right",
                widget = wibox.widget.imagebox
            },
            wibox.widget.textbox("root"),
        }        
    }
end)
-- }}}