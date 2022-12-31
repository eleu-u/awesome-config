myawesomemenu = {
    {"manual", terminal .. " -e man awesome"},
    {"edit config", function()
        awful.spawn.with_shell("cd /home/ele/.config/awesome && code .")
    end},
    {"reload", awesome.restart},
    {"log out", function() 
        awesome.quit() 
    end},
    {"reboot", function()
        awful.spawn("systemctl reboot")
    end},
    {"shutdown", function()
        awful.spawn("systemctl poweroff") -- systemctl poweroff -r
    end}
}

local menu_awesome = {"awesome", myawesomemenu, beautiful.awesome_icon}
local menu_terminal = {"open terminal", terminal}

if has_fdo then
    mymainmenu = freedesktop.menu.build({before = {menu_awesome}, after = {menu_terminal}})
else
    mymainmenu = awful.menu({
        items = {
            menu_awesome,
            {"Debian", debian.menu.Debian_menu.Debian},
            menu_terminal,
        }
    })
end

mylauncher = awful.widget.launcher({image = beautiful.awesome_icon, menu = mymainmenu})