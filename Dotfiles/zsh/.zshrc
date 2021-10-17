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
PROMPT='%B%(!.%F{red}%n%f.%n)@%M %~ %(!.%#.)$vcs_info_msg_0_>%b '
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

# Use vimpager as pager if it's installed
export PAGER=$(command -v vimpager)
if [ -e "$PAGER" ]
then
    alias less=$PAGER
    alias zless=$PAGER
fi

## Aliases
# Give my life some colors & replace some tools with modern equivalents
if [ -e "$(command -v exa)" ]
then
    alias ls='exa --icons --git --group -F'
    alias l='ls'
    alias ll='ls -l'
    alias lla='ls -al'
    alias la='ls -a'
    alias lsd='ls -D'
else
    alias ls='ls --color'
    alias l='ls'
    alias ll='ls -lh'
    alias lla='ls -Alh'
    alias la='ls -A'
    # List directories
    alias lsd='ls -l | grep "^d" | tr -s " " | cut -f9 -d " "' 
fi
if [ -e ~/.config/broot/launcher/bash/br ]
then
    source ~/.config/broot/launcher/bash/br
fi
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
alias free='free -h'

# Display my classes timetable
alias plan='firefox /home/piotr/Documents/studia/rok_III/sem_6/plan.pdf'
alias plan_online='firefox https://fc.put.poznan.pl/sites/default/files/d_INF_1st_6sem.pdf'

# Start bluetooth
alias startbluetooth='sudo systemctl start bluetooth.service && bluetoothctl power on && bluetoothctl'

# Start 32bit wine
alias wine32='WINEARCH=win32 WINEPREFIX=~/.wine32 wine'

# My week starts with monday
alias cal='cal -m'

alias temacs='emacs --no-window-system'
alias rss='canto-curses'

# Use all cores in make
alias make="make -j $(nproc)"

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

# OCaml OPAM configuration
test -r /home/pjtom/.opam/opam-init/init.zsh && . /home/pjtom/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

