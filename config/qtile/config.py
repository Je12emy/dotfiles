from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, KeyChord, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal, send_notification
from libqtile.backend.wayland import InputConfig
import os
import subprocess

mod = "mod4"
terminal = "kitty"
terminal_cmd = terminal + " -o window_padding_width=20 "

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
    Key([mod, "control"], "h", lazy.layout.grow(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.shrink(), desc="Grow window to the right"),
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
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key(
        [mod],
        "f",
        lazy.window.toggle_fullscreen(),
        desc="Toggle fullscreen on the focused window",
    ),
    Key([mod], "t", lazy.window.toggle_floating(), desc="Toggle floating on the focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
    Key([mod], "v", lazy.spawn(terminal_cmd + "pulsemixer"), desc="Open pulsemixer"),
    Key([mod], "n", lazy.spawn(terminal_cmd + "newsboat"), desc="Open netsboat"),
    Key([mod], "b", lazy.spawn("firefox"), desc="Open browser"),
    Key([mod], "e", lazy.spawn(terminal + " ranger"), desc="Open ranger"),
    Key([mod], "d", lazy.spawn(terminal + " nvim /home/jeremy/Shared/todo.txt"), desc="Edit todo.txt"),
    Key([mod], "m", lazy.spawn(terminal + " neomutt"), desc="View email"),
    KeyChord([mod], "p", [
        Key([], "r", lazy.spawn("dmenu_run")),
        Key([], "p", lazy.spawn("passmenu")),
        Key([], "d", lazy.spawn("dm-documents")),
        Key([], "k", lazy.spawn("dm-kill")),
        Key([], "l", lazy.spawn("dm-logout")),
        Key([], "v", lazy.spawn("dm-pipewire-out-switcher")),
    ],
    name="Dmenu"),
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


colors = []
cache='/home/jeremy/.cache/wal/colors'
def load_colors(cache):
    with open(cache, 'r') as file:
        for i in range(8):
            colors.append(file.readline().strip())
    colors.append('#ffffff')
    lazy.reload()
load_colors(cache)

layout_theme = {
    "border_width": 3,
    "margin": 4,
    "border_focus": colors[5],
    "border_normal": colors[6]
}

layouts = [
    layout.MonadTall(**layout_theme),
    layout.Max(**layout_theme),
    # Try more layouts by unleashing below layouts.
    # layout.Columns(border_focus_stack=["#d75f5f", "#8f3d3d"], border_width=4),
    # layout.Stack(num_stacks=2),
    # layout.Bsp(**layout_theme),
    # layout.Matrix(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(**layout_theme),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font="sans",
    fontsize=14,
    padding=3,
)
extension_defaults = widget_defaults.copy()

# screens = [Screen()]
screens = [
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(
                    active=colors[3],
                    this_current_screen_border=colors[2],
                    inactive=colors[2],
                    hide_unused=True,
                    highlight_method="line",
                    highlight_color=[colors[0], colors[0]],
                    urgent_alert_method="line",
                    urgent_border=colors[5]
                ),
                widget.Prompt(),
                widget.WindowName(),
                widget.Chord(
                    chords_colors={
                        "launch": ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                # NB Systray is incompatible with Wayland, consider using StatusNotifier instead
                # widget.StatusNotifier(),
                # widget.Systray(),
                widget.TextBox("|"),
                widget.CPU(),
                widget.TextBox("|"),
                widget.Memory(),
                widget.TextBox("|"),
                widget.TextBox("Network"),
                widget.Net(
                    format='{down:.0f}{down_suffix} ↓↑ {up:.0f}{up_suffix}'
                ),
                widget.TextBox("|"),
                widget.TextBox("Volume"),
                widget.PulseVolume(),
                widget.TextBox("|"),
                widget.CurrentLayout(),
                widget.TextBox("|"),
                widget.CapsNumLockIndicator(),
                widget.TextBox("|"),
                widget.KeyboardLayout(),
                widget.TextBox("|"),
                widget.CheckUpdates(distro = "Arch_paru", no_update_string='No updates'),
                widget.TextBox("|"),
                widget.Clock(format="%Y-%m-%d %I:%M %p"),
                widget.TextBox("|"),
                widget.QuickExit(),
                widget.Sep(padding = 1, background = colors[0], foreground = colors[0])
                # widget.TextBox("|"),
                # widget.QuickExit(),
            ],
            24,
            background=colors[0],
        ),
        # You can uncomment this variable if you see that on X11 floating resize/moving is laggy
        # By default we handle these events delayed to already improve performance, however your system might still be struggling
        # This variable is set to None (no cap) by default, but you can set it to 60 to indicate that you limit it to 60 events per second
        # x11_drag_polling_rate = 60,
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
floats_kept_above = True
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
# wl_input_rules = (
#     "*": InputConfig(kb_layout="latam", kb_variant="latam"),
#     "type:keyboard": InputConfig(kb_layout="latam", kb_variant="latam"),
#     # "*": InputConfig(left_handed=True, pointer_accel=True),
# )

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"

@hook.subscribe.startup
def run_every_startup():
    script = os.path.expanduser("/home/jeremy/.config/qtile/autostart.sh")
    subprocess.run([script])

@hook.subscribe.startup_once
def autostart():
    script = os.path.expanduser("/home/jeremy/.config/qtile/startup.sh")
    subprocess.run([script])
