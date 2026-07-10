# Tell systemd/D-Bus user services (xdg-desktop-portal, etc.) about the
# graphical session. Without this, xdg-desktop-portal never starts under a
# bare WM, so GTK4/libadwaita apps and Firefox can't read the dark color-scheme.
export XDG_CURRENT_DESKTOP=GNOME
dbus-update-activation-environment --systemd --all
systemctl --user start dwm-session.target

exec dwm
