## Command history
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# Ignore commands starting with space
setopt HIST_IGNORE_SPACE

## Styling zsh
# Prompt Theme
autoload -Uz promptinit
promptinit
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
#PROMPT='%B%! %n@%M %~ %(!.%#.)$vcs_info_msg_0_>%b '
PROMPT='%B%n@%M %~ %(!.%#.)$vcs_info_msg_0_>%b '
zstyle ':vcs_info:git:*' formats '%F{240}%b%f '

# Command completion
autoload -Uz compinit
compinit

# Default editor
export EDITOR='vim'

## Colors
# Enable 256 colors support
case $TERM in
"xterm")
    export TERM="xterm-256color"
    ;;
*)
esac

# Fix readability issues of blue color
echo -e "\\e]PC6060f0"

# Use tmux
#[ -z "$TMUX" ] && { tmux attach || exec tmux new-session && exit; }

## Aliases
# Give my life some colors
alias l='ls --color'
alias ll='ls -lh --color'
alias lla='ls -Alh --color'
alias la='ls -A --color'
alias ls='ls --color'
alias grep='grep --color'
alias diff='diff --color'
alias ip='ip -color'

# Be more interactive
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'

# Humanize the output
alias df='df -h'
alias duh='du -h'

# Display my classes timetable
alias plan='firefox /home/piotr/Documents/studia/rok_III/sem_6/plan.pdf'
alias plan_online='firefox https://fc.put.poznan.pl/sites/default/files/d_INF_1st_6sem.pdf'

# List directories
alias lsd='ls -l | grep "^d" | tr -s " " | cut -f9 -d " "'

# Start bluetooth
alias startbluetooth='sudo systemctl start bluetooth.service && bluetoothctl power on && bluetoothctl'

# Start 32bit wine
alias wine32='WINEARCH=win32 WINEPREFIX=~/.wine32 wine'

# My week starts with monday
alias cal='cal -m'

alias temacs='emacs --no-window-system'
alias rss='canto-curses'

## Custom functions
# Change directory and list
cdl(){ cd "$1"; ls }

# Download aur package
aur(){ git clone "https://aur.archlinux.org/$1.git" }

# Convert PDF to black & white
pdfbw(){ gs -sOutputFile="$2" -sDEVICE=pdfwrite -sColorConversionStrategy=Gray -dProcessColorModel=/DeviceGray -dCompatibilityLevel=1.4 -dNOPAUSE -dBATCH "$1" }

# Pipe command output to bat
batstrings(){ strings "$@" | bat }
bathexdump(){ hexdump -C "$@" | bat }
