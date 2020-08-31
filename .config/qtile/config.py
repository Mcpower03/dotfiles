# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

from libqtile.config import Key, Screen, Group, Drag, Click
from libqtile.lazy import lazy
from libqtile import layout, bar, widget, hook

from typing import List  # noqa: F401

import os
import subprocess

mod = "mod4"
myTerm = "kitty"
myConfig = "/home/mikec/.config/qtile/config.py"
keys = [

    # Launch Programs
    Key([mod], "Return",
        lazy.spawn(myTerm),
        desc='Spawn a Terminal'
        ),
    Key([mod], "r",
        lazy.spawn("rofi -show run"),
        desc='Spawn Rofi'
        ),
    Key([mod, "control"], "f",
        lazy.spawn("firefox"),
        desc='Spawn Firefox'
        ),
    Key([mod, "control"], "b",
        lazy.spawn("pcmanfm"),
        desc='Spawn PcmanFm'
        ),
    # Qtile Controls
    Key([mod, "shift"], "r",
        lazy.restart(),
        desc='Restart Qtile'
        ),
    Key([mod, "shift"], "q",
        lazy.shutdown(),
        desc='Exit Qtile'
        ),
    # Sound
    Key([], "XF86AudioMute",
        lazy.spawn("amixer -q set Master toggle"),
        desc='Toggle Audio Mute'
        ),
    Key([], "XF86AudioLowerVolume",
        lazy.spawn("changeVolume 2%- unmute"),
        desc='Decrease Audio Volume'
        ),
    Key([], "XF86AudioRaiseVolume",
        lazy.spawn("changeVolume 2%+ unmute"),
        desc='Increase Audio Volume'
        ),
    # Media
    Key([], "XF86AudioPlay",
        lazy.spawn("playerctl play-pause"),
        desc='Play/Pause Media'
        ),
    Key([], "XF86AudioStop",
        lazy.spawn("playerctl stop"),
        desc='Stop Media Playback'
        ),
    Key([], "XF86AudioPrev",
        lazy.spawn("playerctl previous"),
        desc='Previous Song'
        ),
    Key([], "XF86AudioNext",
        lazy.spawn("playerctl next"),
        desc='Next Song'
        ),
    # Window Manipulation
    Key([mod, "shift"], "space",
        lazy.layout.previous(),
        desc='Swap To Previous Window in Stack'
        ),
    Key([mod], "space",
        lazy.layout.next(),
        desc='Swap To Next Window in Stack'
        ),
    Key([mod, "shift"], "c",
        lazy.window.kill(),
        desc='Close Current Window'
        ),
    Key([mod, "shift"], "Tab",
        lazy.window.toggle_floating(),
        desc='Toggle Floating on Current Window'
        ),
    Key([mod, "shift"], "f",
        lazy.window.toggle_fullscreen(),
        desc='Toggle Fullscreen on Current Window'
        ),
    Key([mod], "k",
        lazy.layout.up(),
        desc='Swap Up In Current Window Stack'
        ),
    Key([mod], "j",
        lazy.layout.down(),
        desc='Swap Down In Current Window Stack'
        ),
    Key([mod, "shift"], "k",
        lazy.layout.shuffle_up(),
        desc='Move Current Window Up In Stack'
        ),
    Key([mod, "shift"], "j",
        lazy.layout.shuffle_down(),
        desc='Move Current Window Down In Stack'
        ),
    Key([mod], "Tab",
        lazy.next_layout(),
        desc='Toggle Layouts'
        ),
    Key([mod], "h",
        lazy.prev_screen(),
        desc='Switch Focus to Left'
        ),
    Key([mod], "l",
        lazy.next_screen(),
        desc='Switch Focus to Right'
        )
]


##### GROUPS #####

group_names = [("Web", {'layout': 'monadtall'}),
               ("Term", {'layout': 'monadtall'}),
               ("School", {'layout': 'monadtall'}),
               ("Game", {'layout': 'max'}),
               ("Music", {'layout': 'monadtall'}),
               ("Chat", {'layout': 'monadtall'}),
               ("Sys", {'layout': 'monadtall'}),
               ("Dev", {'layout': 'monadtall'}),
               ("Extra", {'layout': 'monadtall'})]

groups = [Group(name, **kwargs) for name, kwargs in group_names]

for i, (name, kwargs) in enumerate(group_names, 1):
    keys.append(Key([mod], str(i), lazy.group[name].toscreen()))        # Switch to another group
    keys.append(Key([mod, "shift"], str(i), lazy.window.togroup(name))) # Send current window to another group	

# Colors (Dracula Colorscheme)
colors = [["#282a36", "#282a36"], # Background

          ["#44475a", "#44475a"], # Current Line
          ["#bd93f9", "#bd93f9"], # Purple
          ["#f1fa8c", "#f1fa8c"], # Yellow
          ["#6272a4", "#6272a4"], # Comment
          ["#8be9fd", "#8be9fd"], # Cyan
          ["#f8f8f2", "#f8f8f2"], # Foreground
          ["#50fa7b", "#50fa7b"], # Green
          ["#ffb86c", "#ffb86c"], # Orange
          ["#ff79c6", "#ff79c6"], # Pink 
          ["#ff5555", "#ff5555"]  # Red
          ]

layout_theme = {"border_width": 3,
                "margin": 10,
                "border_focus": "#50fa7b",
                "border_normal": "#6272a4"
                }

layouts = [
    layout.Max(**layout_theme),
    #layout.Stack(num_stacks=2),
    # Try more layouts by unleashing below layouts.
    # layout.Bsp(),
    # layout.Columns(),
    # layout.Matrix(),
     layout.MonadTall(**layout_theme),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
    layout.Floating(**layout_theme),
]

widget_defaults = dict(
    font='JetbrainsMono NF',
    fontsize=13,
    padding=4,
    background=colors[0],
    foreground=colors[2]
    )
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(
                    font = "JetbrainsMono NF",
                    fontsize = 13,
                    margin_y = 4,
                    margin_x = 0,
                    padding_y = 4,
                    padding_x = 4,
                    borderwidth = 4,
                    active = colors[2],
                    inactive = colors[1],
                    rounded = True,
                    highlight_color = colors[1],
                    highlight_method = "line",
                    this_current_screen_border = colors[7],
                    this_screen_border = colors [4],
                    other_current_screen_border = colors[7],
                    other_screen_border = colors[4],
                    foreground = colors[2],
                    background = colors[0]
                    ),
                widget.WindowName(),
                widget.Cmus(
                    foreground = colors[2],
                    noplay_color = colors[4],
                    play_color = colors[8]
                    ),
                widget.Systray(),
                widget.Clock(
                    format='%Y-%m-%d %a %I:%M %p'),
                widget.CurrentLayoutIcon(
                    custom_icon_paths = [os.path.expanduser("~/.config/qtile/icons")],
                    scale = 0.7
                    ),
            ],
            22,
        ),
    ),
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(
                    font = "JetBrainsMono NF",
                    fontsize = 13,
                    margin_y = 4,
                    margin_x = 0,
                    padding_y = 4,
                    padding_x = 4,
                    borderwidth = 4,
                    active = colors[2],
                    inactive = colors[1],
                    rounded = True,
                    highlight_color = colors[1],
                    highlight_method = "line",
                    this_current_screen_border = colors[7],
                    this_screen_border = colors [4],
                    other_current_screen_border = colors[7],
                    other_screen_border = colors[4],
                    foreground = colors[2],
                    background = colors[0]
                    ),
                widget.WindowName(),
                widget.Clock(
                    format='%Y-%m-%d %a %I:%M %p'),
                widget.CurrentLayoutIcon(
                    custom_icon_paths = [os.path.expanduser("~/.config/qtile/icons")],
                    scale = 0.7
                    ),

            ],
            22,
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    {'wmclass': 'confirm'},
    {'wmclass': 'dialog'},
    {'wmclass': 'download'},
    {'wmclass': 'error'},
    {'wmclass': 'file_progress'},
    {'wmclass': 'notification'},
    {'wmclass': 'splash'},
    {'wmclass': 'toolbar'},
    {'wmclass': 'confirmreset'},  # gitk
    {'wmclass': 'makebranch'},  # gitk
    {'wmclass': 'maketag'},  # gitk
    {'wname': 'branchdialog'},  # gitk
    {'wname': 'pinentry'},  # GPG key password entry
    {'wmclass': 'ssh-askpass'},  # ssh-askpass
])
auto_fullscreen = True
focus_on_window_activation = "smart"

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "Qtile"
# Autostart Applications
@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser("~/.config/qtile/autostart.sh")
    subprocess.call([home])
