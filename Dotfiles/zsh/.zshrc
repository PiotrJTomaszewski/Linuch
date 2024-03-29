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

# Make gpg-agent use curses dialog to ask for password
export GPG_TTY=$(tty)

# Make sudo use alias expansion
alias sudo='sudo '

## Colors
# Enable 256 colors support
case $TERM in
"xterm")
    export TERM="xterm-256color"
    ;;
*)
esac

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
    base_ls='exa --icons --git --group -F'
    alias ls="${base_ls}"
    alias l="${base_ls}"
    alias ll="${base_ls} -l"
    alias lla="${base_ls} -al"
    alias la="${base_ls} -a"
    alias lsd="${base_ls} -D"
    alias tree="exa --tree --icons -F"
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

# I don't know who made it but it's awesome
function colorize_ipt {
    sed -E 's/^Chain.*$/\x1b[4m&\x1b[0m/' |\
    sed -E 's/^num.*/\x1b[33m&\x1b[0m/' |\
    sed -E '/([^y] )((REJECT|DROP))/s//\1\x1b[31m\3\x1b[0m/' |\
    sed -E '/([^y] )(ACCEPT)/s//\1\x1b[32m\2\x1b[0m/' |\
    sed -E '/([ds]pt[s]?:)([[:digit:]]+(:[[:digit:]]+)?)/s//\1\x1b[33;1m\2\x1b[0m/' |\
    sed -E '/([[:digit:]]{1,3}\.){3}[[:digit:]]{1,3}(\/([[:digit:]]){1,3}){0,1}/s//\x1b[36;1m&\x1b[0m/g' |\
    sed -E '/([^n] )(LOGDROP)/s//\1\x1b[33;1m\2\x1b[0m/'|\
    sed -E 's/ LOG /\x1b[36;1m&\x1b[0m/'
}
iptables() { /usr/bin/iptables $@ | colorize_ipt }

# Be more interactive
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'

# Humanize the output
alias df='df -h'
alias duh='du -h'
alias free='free -h'

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

