from libqtile import bar, layout, widget, qtile
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

import qtile_extras
from qtile_extras.widget.decorations import PowerLineDecoration

mod = "mod4"
terminal = guess_terminal()

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod, "shift"], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "shift"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "shift"], "e", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
    Key([mod, "shift"], "l", lazy.spawn("betterlockscreen -l"), desc="Lock System"),
    Key([mod], "f", lazy.window.toggle_fullscreen()),
    Key([mod], "e", lazy.spawn("emacsclient -c")),
    Key(["control"], "space", lazy.spawn("dunstctl close")),
    Key([mod], "d", lazy.spawn("/home/cognusboi/.config/rofi/launchers/type-2/launcher.sh")),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +10%")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -10%")),
    Key([], "XF86AudioMute", lazy.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle")),
    Key([], "XF86AudioMicMute", lazy.spawn("pactl set-source-mute @DEFAULT_SOURCE@ toggle")),
    Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl s 10%-")),
    Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl s +10%")),
    Key([], "XF86Calculator", lazy.spawn("speedcrunch")),
]

groups = [Group(i) for i in "123456789"]

for i in groups:
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + shift + letter of group = switch to & move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + letter of group = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )

catppuccin_latte = {
    'Rosewater':'#dc8a78',
    'Flamingo':'#dd7878',
    'Pink':'#ea76cb',
    'Mauve':'#8839ef',
    'Red':'#d20f39',
    'Maroon':'#e64553',
    'Peach':'#fe640b',
    'Yellow':'#df8e1d',
    'Green':'#40a02b',
    'Teal':'#179299',
    'Sky':'#04a5e5',
    'Sapphire':'#209fb5',
    'Blue':'#1e66f5',
    'Lavender':'#7287fd',
    'Text':'#4c4f69',
    'Subtext1':'#5c5f77',
    'Subtext0':'#6c6f85',
    'Overlay2':'#7c7f93',
    'Overlay1':'#8c8fa1',
    'Overlay0':'#9ca0b0',
    'Surface2':'#acb0be',
    'Surface1':'#bcc0cc',
    'Surface0':'#ccd0da',
    'Base':'#eff1f5',
    'Mantle':'#e6e9ef',
    'Crust':'#dce0e8',
}

catppuccin_macchiato = { # Macchiato
    'Rosewater':'#f4dbd6',
    'Flamingo':'#f0c6c6',
    'Pink':'#f5bde6',
    'Mauve':'#c6a0f6',
    'Red':'#ed8796',
    'Maroon':'#ee99a0',
    'Peach':'#f5a97f',
    'Yellow':'#eed49f',
    'Green':'#a6da95',
    'Teal':'#8bd5ca',
    'Sky':'#91d7e3',
    'Sapphire':'#7dc4e4',
    'Blue':'#8aadf4',
    'Lavender':'#b7bdf8',
    'Text':'#cad3f5',
    'Subtext1':'#b8c0e0',
    'Subtext0':'#a5adcb',
    'Overlay2':'#939ab7',
    'Overlay1':'#8087a2',
    'Overlay0':'#6e738d',
    'Surface2':'#5b6078',
    'Surface1':'#494d64',
    'Surface0':'#363a4f',
    'Base':'#24273a',
    'Mantle':'#1e2030',
    'Crust':'#181926',
}

nord = {
    'gray': ["#2E3440",
             "#3B4252",
             "#434C5E",
             "#4C566A"],
    'white': ["#D8DEE9",
              "#E5E9F0",
              "#ECEFF4"],
    'green-blue':"#8FBCBB",
    'sky-blue':"#88C0D0",
    'purple-blue':"#81A1C1",
    'blue':"#5E81AC",
    'red':"#BF616A",
    'orange':"#D08770",
    'yellow':"#EBCB8B",
    'green':"#A3BE8C",
    'purple':"#B48EAD",
    'black': "#242933"
}

symbols = {
    'volume': ' 󰕾 ',
    'battery': '  ',
	'power_off': ' ',
	'calendar': ' '
}

def get_symbol(symbol, fg, bg, ft=25, padding=0):
    return widget.TextBox(
	text=symbols[symbol],
	padding=padding,
	font="feather",
	fontsize=ft,
	foreground=fg,
	background=bg
    )

arrow_powerlineRight = {
    "decorations": [
        PowerLineDecoration(
            path="arrow_right",
            size=11,
        )
    ]
}
arrow_powerlineLeft = {
    "decorations": [
        PowerLineDecoration(
            path="arrow_left",
            size=11,
        )
    ]
}
rounded_powerlineRight = {
    "decorations": [
        PowerLineDecoration(
            path="rounded_right",
            size=11,
        )
    ]
}
rounded_powerlineLeft = {
    "decorations": [
        PowerLineDecoration(
            path="rouded_left",
            size=11,
        )
    ]
}
slash_powerlineRight = {
    "decorations": [
        PowerLineDecoration(
            path="forward_slash",
            size=11,
        )
    ]
}
slash_powerlineLeft = {
    "decorations": [
        PowerLineDecoration(
            path="back_slash",
            size=11,
        )
    ]
}

layouts = [
    #    layout.Columns(border_focus_stack=["#d75f5f", "#8f3d3d"], border_width=4),
    #    layout.Max(),
    # Try more layouts by unleashing below layouts.
	layout.Bsp(margin_on_single=15, margin=12,
			   border_focus=catppuccin_macchiato['Surface1'],
			   border_normal=catppuccin_macchiato['Surface0']),
    layout.Stack(margin=15, num_stacks=1, border_focus="#414868"),
    # layout.Matrix(),
    # layout.MonadTall(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    #layout.VerticalTile(),
    layout.Zoomy(margin=8),
]

widget_defaults = dict(
    font="JetBrainsMono Nerd Font",
    fontsize=15,
    padding=8,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.CurrentLayout(
                    foreground=catppuccin_macchiato['Text'],
                    background=catppuccin_macchiato['Base']
                ),
                widget.GroupBox(
		    background=catppuccin_latte['Blue'],
		    active=catppuccin_latte['Base'],
		    inactive=catppuccin_latte['Sky'],
                    highlight_method='block',
                    this_current_screen_border='#073592',
                    rounded=False,
                    disable_drag=True
                ),
                qtile_extras.widget.Spacer(
                    length=1,
                    background=catppuccin_latte['Blue'],
                    **rounded_powerlineRight
                ),
                widget.WindowTabs(background=catppuccin_macchiato['Base']),
                qtile_extras.widget.Spacer(
                    length=1,
                    background=catppuccin_macchiato['Base'],
                    **rounded_powerlineRight
                ),
                widget.Mpd2(
                    background=catppuccin_latte['Red'],
                    foreground=catppuccin_latte['Crust'],
                    status_format="{play_status} {artist}/{title}"
                ),
                qtile_extras.widget.Spacer(
                    length=1,
                    background=catppuccin_latte['Red'],
                    **slash_powerlineRight
                ),
                get_symbol("battery", catppuccin_macchiato['Text'], catppuccin_macchiato['Base'], ft=18),
                widget.Battery(
                    background=catppuccin_macchiato['Base'],
                    foreground=catppuccin_macchiato['Text'],
                    format='{percent:2.0%}'
                ),
                qtile_extras.widget.Spacer(
                    length=1,
                    background=catppuccin_macchiato['Base'],
                    **slash_powerlineRight
                ),
                get_symbol("volume", catppuccin_latte['Base'], catppuccin_latte['Mauve'], ft=20),
                widget.PulseVolume(
                    background=catppuccin_latte['Mauve'],
                    foreground=catppuccin_latte['Base']
                ),
                qtile_extras.widget.Spacer(
                    length=1,
                    background=catppuccin_latte['Mauve'],
                    **slash_powerlineRight
                ),
                get_symbol("calendar", catppuccin_macchiato['Sky'], catppuccin_macchiato['Base'], ft=16),
                widget.Clock(
                    format="%d/%m/%y %I:%M %p",
                    background=catppuccin_macchiato['Base'],
                    foreground=catppuccin_macchiato['Sky']
                ),
                qtile_extras.widget.Spacer(
                    length=1,
                    background=catppuccin_macchiato['Base'],
                    **slash_powerlineRight
                ),
                widget.TextBox(
                    fontsize=18,
                    text=symbols['power_off'],
                    background=catppuccin_latte['Red'],
                    foreground=catppuccin_latte['Base'],
					mouse_callbacks={
						"Button1": lambda: qtile.cmd_spawn('/home/cognusboi/.config/rofi/powermenu/type-2/powermenu.sh')
                    }
                ),
            ],
            30,
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
