# Set the default tools
export EDITOR=vim
export VISUAL=vim
export TERMINAL=alacritty

# Define XDG variables
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# Specify locations of various configuration files
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"
export LYNX_CFG="$XDG_CONFIG_HOME/lynx/lynx.cfg"
export LYNX_LSS="$XDG_CONFIG_HOME/lynx/lynx.lss"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export PSQLRC="$XDG_CONFIG_HOME/pg/psqlrc"
export SCREENRC="$XDG_CONFIG_HOME/screen/screenrc"
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"

# Specify locations of various state files
export HISTFILE="$XDG_STATE_HOME/bash_history"
export LESSHISTFILE="$XDG_STATE_HOME/lesshst"
export PSQL_HISTORY="$XDG_STATE_HOME/psql_history"
export PYTHON_HISTORY="$XDG_STATE_HOME/python_history"
export SQLITE_HISTORY="$XDG_STATE_HOME/sqlite_history"

# Specify locations of various data directories
export CARGO_HOME="$XDG_DATA_HOME/cargo"
export GOPATH="$XDG_DATA_HOME/go"
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"

# Specify locations of various cache files
export GOMODCACHE="$XDG_CACHE_HOME/go/mod"

# Add some directories to PATH
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$GOPATH/bin"

# Source `~/.bashrc` if exists
[[ -f ~/.bashrc ]] && . ~/.bashrc

# Autostart X server at login
[[ -z "$DISPLAY" && "$XDG_VTNR" -eq 1 ]] && exec startx

# vim:ts=4:sts=4:sw=4:et:
