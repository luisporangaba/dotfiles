#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '


### Default programs

export EDITOR="nvim"
export TERMINAL="kitty"
export BROWSER="firefox"
export IMAGE_VIEWER="swayimg"

### alias:
# confirm before overwriting something
alias cp="cp -iv"
alias mv='mv -iv'
alias rm='rm -iv'

# get top process eating memory
alias psmem='ps axch -o cmd,%mem --sort=-%mem | head'

# get top process eating cpu ##
alias pscpu='ps axch -o cmd,%cpu --sort=-%cpu | head'

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --bash)"

# Set up Zoxide, a better cd
eval "$(zoxide init bash)"

# Shell wrapper that provides the ability to change the current working directory when exiting Yazi
function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

### PATH:
# XDG standards -------------------------------------------------
if [ -z "$XDG_CONFIG_HOME" ] ; then
    export XDG_CONFIG_HOME="$HOME/.config"
fi

if [ -z "$XDG_DATA_HOME" ] ; then
    export XDG_DATA_HOME="$HOME/.local/share"
fi

if [ -z "$XDG_STATE_HOME" ] ; then
    export XDG_STATE_HOME="$HOME/.local/state"
fi

if [ -z "$XDG_CACHE_HOME" ] ; then
    export XDG_CACHE_HOME="$HOME/.cache"
fi

# User Config ---------------------------------------------------

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/.scripts" ] ;
  then PATH="$HOME/.scripts:$PATH"
fi

if [ -d "$HOME/.cargo/bin/" ] ;
  then PATH="$HOME/.cargo/bin/:$PATH"
fi

# Neovim binary:
if [ -d "$HOME/Builds/nvim/neovim_build/bin" ] ;
  then PATH="$HOME/Builds/nvim/neovim_build/bin:$PATH"
fi

# Spark----------------------------------------------------------
if [ -z "$SPARK_HOME" ] ; then
  export SPARK_HOME=$HOME/Builds/apache_spark/spark
fi

if [ -d "$SPARK_HOME/bin" ] ;
  then PATH="$SPARK_HOME/bin:$PATH"
fi

if [ -d "$SPARK_HOME/sbin" ] ;
  then PATH="$SPARK_HOME/sbin:$PATH"
fi

# PySpark driver environment variables to open Spark in browser using "pyspark". Test it inside the notebook using "print(sc)" or "sc.version". sc stands for "spark context".
if [ -z "$PYSPARK_DRIVER_PYTHON" ] ; then
  export PYSPARK_DRIVER_PYTHON=jupyter
fi

if [ -z "$PYSPARK_DRIVER_PYTHON_OPTS" ] ; then
  export PYSPARK_DRIVER_PYTHON_OPTS=notebook
fi
# ------------------------------------------------

# allow global package installations for the current user
export npm_config_prefix="$HOME/.local"

# Clean-up:
export IPYTHONDIR="${XDG_CONFIG_HOME}/ipython"
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME/jupyter"
export LESSHISTFILE="$XDG_STATE_HOME/less/history"
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
