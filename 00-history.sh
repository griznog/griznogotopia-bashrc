#!/bin/bash

# Store history in a hostname specific file, keeping history forever,
# time stamping the commands and ignoring noisy commands.
export HISTFILE=$HOME/.bash_history_$(hostname -s)
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
export HISTIGNORE='ls:bg:fg:history'
