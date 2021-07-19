-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

-- Widget and layout library
local wibox = require("wibox")

-- Theme handling library
local beautiful = require("beautiful")

-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({
        preset = naughty.config.presets.critical,
        title = "Oops, there were errors during startup!",
        text = awesome.startup_errors
    })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function(err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({
            preset = naughty.config.presets.critical,
            title = "Oops, an error happened!",
            text = tostring(err)
        })
        in_error = false
    end)
end

-- Themes define colours, icons, font and wallpapers.
-- default  gtk  sky  xresources  zenburn
beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")
beautiful.font = "Monospace 12"
beautiful.useless_gap = 3
beautiful.wallpaper = '/usr/share/backgrounds/archlinux/mountain.jpg'
beautiful.border_width = 0
beautiful.border_focus = "#FF622C"
beautiful.border_normal = "#CCCCCC"
beautiful.notification_max_height = 100

-- This is used later as the default terminal and editor to run.
TERMINAL = "alacritty"
EDITOR = os.getenv("EDITOR") or "nvim"
EDITOR_COMMAND = TERMINAL .. " -e " .. EDITOR

-- Default modkey.
MODKEY = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.tile.right,
    awful.layout.suit.tile.left,
    awful.layout.suit.fair,
    awful.layout.suit.max,
    awful.layout.suit.floating
}

-- Create a launcher widget and a main menu
MY_AWESOME_MENU = {
    {
        "hotkeys",
        function() hotkeys_popup.show_help(nil, awful.screen.focused()) end
    },
    {
        "manual",
        TERMINAL .. " -e man awesome"
    },
    {
        "edit config",
        EDITOR_COMMAND .. " " .. awesome.conffile
    },
    {
        "restart",
        awesome.restart
    },
    {
        "quit",
        function() awesome.quit() end
    }
}

MY_MAIN_MENU = awful.menu({
    items = {
        {"awesome", MY_AWESOME_MENU, beautiful.awesome_icon},
        {"open terminal", TERMINAL}
    }
})

-- Menubar configuration
menubar.utils.terminal = TERMINAL

-- Keyboard map indicator and switcher
MY_KEYBOARD_LAYOUT = awful.widget.keyboardlayout()

-- Create a textclock widget
MY_TEXT_CLOCK = wibox.widget.textclock()

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
    awful.button({}, 1, function(t) t:view_only() end),
    awful.button({MODKEY}, 1, function(t)
        if client.focus then client.focus:move_to_tag(t) end
    end),
    awful.button({}, 3, awful.tag.viewtoggle),
    awful.button({MODKEY}, 3, function(t)
        if client.focus then client.focus:toggle_tag(t) end
    end),
    awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({}, 5, function(t)
        awful.tag.viewprev(t.screen)
    end)
)

local tasklist_buttons = gears.table.join(
    awful.button({}, 1, function(c)
        if c == client.focus then
            c.minimized = true
        else
            c:emit_signal("request::activate", "tasklist", {raise = true})
        end
    end),
    awful.button({}, 3, function()
        awful.menu.client_list({theme = {width = 250}})
    end),
    awful.button({}, 4, function() awful.client.focus.byidx(1) end),
    awful.button({}, 5, function()
        awful.client.focus.byidx(-1)
    end)
)

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then wallpaper = wallpaper(s) end
        gears.wallpaper.maximized(wallpaper, s, true)
        awful.spawn.with_shell("nitrogen --restore")
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

TAGS = {"a", "s", "d", "f", "g"}
awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    -- awful.tag(TAGS, s, awful.layout.layouts[1])
    awful.tag.add("general", {
        layout = awful.layout.layouts[1],
        screen = s,
        selected = true
    })

    awful.tag.add("chat", {layout = awful.layout.layouts[1], screen = s})
    awful.tag.add("misc", {layout = awful.layout.suit.floating, screen = s})
    awful.tag.add("network", {layout = awful.layout.suit.floating, screen = s})
    awful.tag.add("jack", {layout = awful.layout.suit.floating, screen = s})

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                              awful.button({}, 1,
                                           function() awful.layout.inc(1) end),
                              awful.button({}, 3,
                                           function()
            awful.layout.inc(-1)
        end), awful.button({}, 4, function() awful.layout.inc(1) end),
                              awful.button({}, 5,
                                           function()
            awful.layout.inc(-1)
        end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.all,
        buttons = taglist_buttons,
        style = {spacing = 6}
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons
    }

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, visible = false })

    -- Add widgets to the wibox
    s.mywibox:setup{
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
            s.mypromptbox
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            MY_KEYBOARD_LAYOUT,
            wibox.widget.systray(),
            MY_TEXT_CLOCK,
            s.mylayoutbox
        }
    }
end)
-- }}}

root.buttons(
    gears.table.join(
        awful.button({}, 3, function() MY_MAIN_MENU:toggle() end),
        awful.button({}, 4, awful.tag.viewnext),
        awful.button({}, 5, awful.tag.viewprev)
    )
)

GLOBAL_KEYS = gears.table.join(
    awful.key(
        {MODKEY, "Shift"}, "/",
        hotkeys_popup.show_help,
        { description = "show help", group = "awesome" }
    ),
    awful.key(
        {MODKEY}, "Left",
        awful.tag.viewprev,
        { description = "view previous", group = "tag" }
    ),
   awful.key(
       {MODKEY}, "Right",
       awful.tag.viewnext,
       { description = "view next", group = "tag" }
    ),
    awful.key(
        {MODKEY}, "Escape",
        awful.tag.history.restore,
        { description = "go back", group = "tag" }
    ),
    awful.key(
        {MODKEY}, "j",
        function() awful.client.focus.bydirection("down") end,
        { description = "move focus down", group = "client" }
    ),
    awful.key(
        {MODKEY}, "k",
        function() awful.client.focus.bydirection("up") end,
        { description = "move focus up", group = "client" }
    ),
    awful.key(
        {MODKEY}, "h",
        function() awful.client.focus.bydirection("left") end,
        { description = "move focus left", group = "client" }
    ),
    awful.key(
        {MODKEY}, "l",
        function() awful.client.focus.bydirection("right") end,
        { description = "move focus right", group = "client" }
    ),
    awful.key(
        {MODKEY, "Control"}, "w",
        function() MY_MAIN_MENU:show() end,
        { description = "show main menu", group = "awesome" }
    ),

    -- Layout manipulation
    awful.key(
        {MODKEY, "Control"}, "j",
        function() awful.client.swap.bydirection("down") end,
        { description = "swap with client down", group = "client" }
    ),
    awful.key(
        {MODKEY, "Control"}, "k",
        function() awful.client.swap.bydirection("up") end,
        { description = "swap with client up", group = "client" }
    ),
    awful.key(
        {MODKEY, "Control"}, "h",
        function() awful.client.swap.bydirection("left") end,
        { description = "swap with client left", group = "client" }
    ),
    awful.key(
        {MODKEY, "Control"}, "l",
        function() awful.client.swap.bydirection("right") end,
        { description = "swap with client right", group = "client" }
    ),
    awful.key(
        {MODKEY}, "u",
        awful.client.urgent.jumpto,
        { description = "jump to urgent client", group = "client" }
    ),
    awful.key(
        {MODKEY}, "Tab",
        function() awful.client.focus.history.previous() if client.focus then client.focus:raise() end end,
        { description = "go back", group = "client" }
    ),

    -- Standard program
    awful.key(
        {MODKEY}, "Return",
        function() awful.spawn(TERMINAL) end,
        { description = "open a terminal", group = "launcher" }
    ),
    awful.key(
        {MODKEY, "Control"}, "r",
        awesome.restart,
        { description = "reload awesome", group = "awesome" }
    ),
    awful.key(
        {MODKEY, "Control"}, "q",
        awesome.quit,
        {description = "quit awesome", group = "awesome"}
    ),
    awful.key(
        {MODKEY, "Shift"}, "k",
        function() awful.tag.incmwfact(0.05) end,
        { description = "increase master width factor", group = "layout" }
    ),
    awful.key(
        {MODKEY, "Shift"}, "j",
        function() awful.tag.incmwfact(-0.05) end,
        { description = "decrease master width factor", group = "layout" }
    ),
    awful.key(
        {MODKEY}, "space",
        function() awful.layout.inc(1) end,
        { description = "select next", group = "layout" }
    ),
    awful.key(
        {MODKEY, "Shift"}, "space",
        function() awful.layout.inc(-1) end,
        { description = "select previous", group = "layout" }
    ),
    awful.key(
        {MODKEY, "Control"}, "n",
        function()
            local c = awful.client.restore()
            if c then
                c:emit_signal("request::activate", "key.unminimize", {raise = true})
            end
        end,
        { description = "restore minimized", group = "client" }
    ),

    -- Prompt
    awful.key(
        {MODKEY, "Control"}, "p",
        function() awful.util.spawn_with_shell("sleep 0.5 && scrot -b -u") end,
        { description = "run prompt", group = "launcher" }
    ),
    awful.key(
        {MODKEY, "Shift"}, "p",
        function() awful.util.spawn_with_shell("sleep 0.5 && scrot -s") end,
        { description = "run prompt", group = "launcher" }
    ),
    awful.key(
        {MODKEY}, "/",
        function() awful.util.spawn("rofi -show combi") end,
        { description = "run prompt", group = "launcher" }
    ),
    awful.key(
        {MODKEY}, "x",
        function()
            awful.prompt.run {
                prompt = "Run Lua code: ",
                textbox = awful.screen.focused().mypromptbox.widget,
                exe_callback = awful.util.eval,
                history_path = awful.util.get_cache_dir() .. "/history_eval"
            }
        end,
        { description = "lua execute prompt", group = "awesome" }
    ),

    -- Menubar
    awful.key(
        {MODKEY}, "p",
        function() menubar.show() end,
        { description = "show the menubar", group = "launcher" }
    ),
    awful.key({ MODKEY }, "b",
          function ()
              local myscreen = awful.screen.focused()
              myscreen.mywibox.visible = not myscreen.mywibox.visible
          end,
          { description = "toggle statusbar", group="layout" }
    )
)

CLIENT_KEYS = gears.table.join(
    awful.key(
        {MODKEY}, "i",
        function(c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        { description = "toggle fullscreen", group = "client" }
    ),
    awful.key(
        {MODKEY}, "w",
        function(c) c:kill() end,
        { description = "close", group = "client" }
    ),
    awful.key(
        {MODKEY, "Control"}, "m",
        function(c)
          c.maximized, c.maximized_vertical, c.maximized_horizontal = false, false, false
        end,
        { description = "restore maximized", group = "client" }
    ),
    awful.key(
        {MODKEY, "Control"}, "space",
        awful.client.floating.toggle,
        { description = "toggle floating", group = "client" }
    ),
    awful.key(
        {MODKEY, "Control"}, "Return",
        function(c) c:swap(awful.client.getmaster()) end,
        { description = "move to master", group = "client" }
    ),
    awful.key(
        {MODKEY}, "o",
        function(c) c:move_to_screen() end,
        { description = "move to screen", group = "client" }
    )
)

-- Bind keys to tags
for i, _tag in ipairs(TAGS) do
    GLOBAL_KEYS = gears.table.join(
        GLOBAL_KEYS,
        -- View tag only
        awful.key(
            {MODKEY}, _tag,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then tag:view_only() end
            end,
            { description = "view tag " .. _tag, group = "tag" }
        ),
        -- Move client to tag.
       awful.key(
           {MODKEY, "Control"}, _tag,
           function()
               if client.focus then
                   local tag = client.focus.screen.tags[i]
                   if tag then client.focus:move_to_tag(tag) end
               end
           end,
           { description = "move focused client to tag " .. _tag, group = "tag" }
       ),
        -- Toggle client to tag.
       awful.key(
           {MODKEY, "Shift"}, _tag,
           function()
               if client.focus then
                   local tag = client.focus.screen.tags[i]
                   if tag then client.focus:toggle_tag(tag) end
               end
           end,
           { description = "move focused client to tag " .. _tag, group = "tag" }
       )
    )
end

CLIENT_BUTTONS = gears.table.join(
    awful.button(
        {}, 1,
        function(c) c:emit_signal("request::activate", "mouse_click", {raise = true}) end
    ),
    awful.button(
        {MODKEY}, 1,
        function(c)
            c:emit_signal("request::activate", "mouse_click", {raise = true})
            awful.mouse.client.move(c)
        end
    ),
    awful.button(
        {MODKEY}, 3,
        function(c)
            c:emit_signal("request::activate", "mouse_click", {raise = true})
            awful.mouse.client.resize(c)
        end
    )
)

-- Set keys
root.keys(GLOBAL_KEYS)

-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    {
        rule = {},
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = CLIENT_KEYS,
            buttons = CLIENT_BUTTONS,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap +
                awful.placement.no_offscreen
        }
    },
    -- Floating clients.
    {
        rule_any = {
            instance = {
                "DTA", -- Firefox addon DownThemAll.
                "copyq", -- Includes session name in class.
                "pinentry"
            },
            class = {
                "Arandr", "Blueman-manager", "Gpick", "Kruler", "MessageWin", -- kalarm.
                "Sxiv", "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
                "Wpa_gui", "veromix", "xtightvncviewer"
            },

            -- Note that the name property shown in xprop might be set slightly after creation of the client
            -- and the name shown there might not match defined rules here.
            name = {
                "Event Tester" -- xev.
            },
            role = {
                "AlarmWindow", -- Thunderbird's calendar.
                "ConfigManager", -- Thunderbird's about:config.
                "pop-up" -- e.g. Google Chrome's (detached) Developer Tools.
            }
        },
        properties = {floating = true}
    },
    -- Jack clients
    {
        rule_any = {class = {"QJackCtl", "Spotify"}},
        properties = {tag = "Jack", floating = true}
    },
    -- VirtualBox
    {
        rule_any = {class = {"VirtualBox"}},
        properties = {tag = "Misc", floating = true, border_width = 0}
    }

}

-- Signals

-- Big old borders
client.connect_signal(
    "focus",
    function(c)
        c.border_color = beautiful.border_focus
    end
)
client.connect_signal("unfocus",
    function(c)
        c.border_color = beautiful.border_normal
    end
)

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
    if not awesome.startup then awful.client.setslave(c) end
    if awesome.startup and not c.size_hints.user_position and
        not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Focus on tag change
local function focus_on_last_in_history(screen)
    local c = awful.client.focus.history.get(screen, 0)
    if not (c == nil) then
        client.focus = c
        c:raise()
    end
end

tag.connect_signal(
    "property::selected",
    function() focus_on_last_in_history(mouse.screen) end
)

-- Autostart
awful.spawn.with_shell("picom")
awful.spawn.with_shell("lxsession")
awful.spawn.with_shell("nitrogen --restore")
awful.spawn.with_shell("setxkbmap -layout us -variant altgr-intl")
awful.spawn.with_shell("enpass")
awful.spawn.with_shell("nm-applet")
