#!/bin/bash
#
# author: griznog
# purpose: Set a prompt with some colors and extra info.

# Set a noticeable prompt.
if [[ $- == *i* ]]; then
    export PS1="\[\033[38;5;2m\][\[$(tput sgr0)\]\[\033[38;5;9m\]I am \u!\[$(tput sgr0)\]\[\033[38;5;2m\]@\[$(tput sgr0)\]\[\033[38;5;11m\]\h\[$(tput sgr0)\]\[\033[38;5;2m\]\[$(tput sgr0)\]:\[$(tput bold)\]\[\033[38;5;13m\]\[\033[48;5;8m\]\$(dynamicprompt)\[$(tput sgr0)\]\[\e[0m\]\[$(tput sgr0)\]:\[\033[38;5;12m\]\W\[$(tput sgr0)\]\[\033[38;5;2m\]]\\$\[$(tput sgr0)\] \[$(tput sgr0)\]"

    # Immediately flush commands to history.
    # Update xterm and screen title bars.
    export PROMPT_COMMAND="history -a;"'echo -ne "\033]0;${USER}@${HOSTNAME}${WW_PROMPT}:${PWD}\007"'
fi

function dynamicprompt () {
    local prompt=""
    # SVN Repo
    [[ -x /usr/bin/svn ]] && \
        local svnrepo=$(svn info 2>&1 | sed -n -e 's#^Repository Root:.*/\(.*\)$#\1#p')

    # Git branch and remote (if exists.)
    if [[ -x /usr/bin/git ]]; then 
        # FInd the branch we are on, this is pretty cheap.
        local gitbranch=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
        # If there is a branch, find the origin, if there is one.
        [[ -n ${gitbranch} ]] && local gitremote=$(git config --get remote.origin.url)
    fi

    if [[ -n "${gitremote}${gitrepo}${svnrepo}" ]]; then
        # Build prompt, starting with git.
        if [[ -n ${gitremote} ]]; then
            prompt="${prompt}${gitremote}(${gitbranch})"
        elif [[ -n ${gitrepo} ]]; then
            prompt="${prompt}git(${gitbranch})"
        fi

        [[ -n ${svnrepo} ]] && prompt="${prompt}svn://${svnrepo}"
    fi

    echo -n ${prompt}
}
export -f dynamicprompt
