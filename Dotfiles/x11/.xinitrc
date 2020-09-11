[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
xbindkeys &
#xflux -l 52.1 -g 17.3
#conky -d -q -b -c ~/.config/conky/conkyrc_sysinfo -p 5 &
#conky -d -q -b -c ~/.config/conky/conkyrc_network -p 5 &
#conky -d -q -b -c ~/.config/conky/conkyrc_media -p 5 &
unclutter &
xscreensaver -no-splash &
xss-lock -- xscreensaver-command -lock &
#lxsession &
awesome
#i3
