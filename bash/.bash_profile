# Add directory containing user-specific command binaries to PATH
export PATH="$PATH:$HOME/.local/bin"

# Set the default tools
export EDITOR=vim
export VISUAL=vim
export TERMINAL=alacritty

# Define XDG variables
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# Specify locations of various configuration files
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"
export SCREENRC="$XDG_CONFIG_HOME/screen/screenrc"
export LYNX_CFG="$XDG_CONFIG_HOME/lynx/lynx.cfg"
export LYNX_LSS="$XDG_CONFIG_HOME/lynx/lynx.lss"

# Specify locations of various state files
export LESSHISTFILE="$XDG_STATE_HOME/lesshst"
export HISTFILE="$XDG_STATE_HOME/bash_history"

# Source `~/.bashrc` if exists
[[ -f ~/.bashrc ]] && . ~/.bashrc

# Autostart X server at login
[[ -z "$DISPLAY" && "$XDG_VTNR" -eq 1 ]] && exec startx

# vim:ts=4:sts=4:sw=4:et:
