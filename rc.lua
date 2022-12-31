-- IMPORTS
pcall(require, "luarocks.loader")

gears = require("gears")
awful = require("awful")

require("awful.autofocus")

wibox = require("wibox") -- widget and layouts
beautiful = require("beautiful") -- theme handling

naughty = require("naughty") -- notification library
menubar = require("menubar")

hotkeys_popup = require("awful.hotkeys_popup")
require("awful.hotkeys_popup.keys")

debian = require("debian.menu")
has_fdo, freedesktop = pcall(require, "freedesktop")

-- // STUFF !! --

beautiful.init("/home/ele/.config/awesome/theme/theme.lua")

require("error_checks")
require("globals")

require("application_launcher")
require("wibar")
require("keys")

require("windows")

-- OTHER STUFF !! :D --

beautiful.notification_icon_size = 64
beautiful.notification_opacity = 0.90
--beautiful.notification_shape = gears.shape.rounded_rect

-- sets notif position to bottom right
--for _, preset in pairs(naughty.config.presets) do
--    preset.position = "top_left"
--end

quick_notify("IMPORTANT", "i like girls")
quick_notify("border_normal", gears.filesystem.get_themes_dir())

awful.spawn.once("compton") -- runs compton to allow transparent windows 

-- desktop icons --

--for s in screen do
--    freedesktop.desktop.add_icons({screen = s})
--end