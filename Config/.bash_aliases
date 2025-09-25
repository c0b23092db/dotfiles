########## エイリアス ##########

##### デフォルト #####
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# カラーモード(enable color support of ls and also add handy aliases) #
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

##### Windows,Mac #####
alias cls='clear'
alias ii='xdg-open'
alias open='xdg-open'
alias start='xdg-open'

##### Linux #####
alias relogin='exec $SHELL -l'

##### 短縮 #####
alias l='ls -1'
alias la='ls -A'
alias ll='ls -al'
alias v='nvim'
alias m='micro'
alias auu='sudo apt -y update;sudo apt -y upgrade'

##### 関数 #####
function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    IFS= read -r -d '' cwd < "$tmp"
    [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
    rm -f -- "$tmp"
}
