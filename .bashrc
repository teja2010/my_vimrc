# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

##############################################################################
## TT's edits
#
alias ctags='/home/teja/apps/universal_ctags/usr_local/bin/ctags'
alias etags='/home/teja/apps/universal_ctags/usr_local/bin/ctags'
alias grep='grep --color=auto'
alias ls='ls --color'
alias ll='ls -lAh'
alias l='ls'
alias dont_ask='eval $(ssh-agent -s) && ssh-add ~/.ssh/id_rsa'
alias create_TTT='sort -u TAGS  > cscope.TTT &'
#alias c2s_create='find * /usr/include/* -name "*.[ch]" -o  -name "*.cpp" > cscope.files; cat cscope.files | xargs etags -a ; cscope -b ; create_TTT'
#alias cs_create='find -L * /usr/include/* -name "*.[ch]" -o  -name "*.cpp" > cscope.files; cat cscope.files | xargs etags -a ; cscope -b ; create_TTT'
#alias cs_rebuild='etags -a  cscope.files ; cscope -b ; create_TTT'

#expt, parallel
alias py_create='find -L * -name "*.py" > cscope.files1; cat cscope.files1 | xargs etags -a ; cp cscope.files1 cscope.files; find -L /usr/include/* -name "*.[ch]" -o -name "*.cpp" >> cscope.files; cscope -b ; create_TTT'
#alias cs_create='find -L * -name "*.[ch]" -o  -name "*.cpp" > cscope.files1; cat cscope.files1 | xargs etags -a ; cp cscope.files1 cscope.files; find -L /usr/include/* -name "*.[ch]" -o -name "*.cpp" >> cscope.files; cscope -b ; create_TTT'
alias cs_create='find -L * -name "*.[ch]" -o  -name "*.cpp" > cscope.files; find -L /usr/include/* -name "*.[ch]" -o -name "*.cpp" >> cscope.files; cat cscope.files | xargs etags -a ; cscope -b ; create_TTT'
#alias cs_rebuild='cat cscope.files1 | xargs etags -a  ;(cscope -b &> /dev/null ) ; create_TTT'
alias cs_rebuild='cat cscope.files | xargs etags -a  ;(cscope -b &> /dev/null ) ; create_TTT'

alias cs5_create='find -L * /usr/include/* -name "*.[ch]" -o  -name "*.cpp" > cscope.files; cat ~/my_include/include.files >> cscope.files ; cat cscope.files | xargs etags -a ; cscope -b ; create_TTT'
alias cs5_rebuild='cat ~/my_include/include.files >> cscope.files ; cs_rebuild'

alias csk_create='find net/ include/ kernel/ init/  drivers/net/ethernet/mellanox/ -name  "*.[ch]" > cscope.files ; cat cscope.files | xargs etags -a ; cscope -bqk ; create_TTT'
alias csk_cmore='find net/ include/ kernel/ init/ mm/ fs/ lib/ security/ drivers/net/ethernet/mellanox/ drivers/platform/msm/ipa/ drivers/net/ethernet/qualcomm/rmnet/ -name  "*.[ch]" > cscope.files ; cat cscope.files | xargs etags -a ; cscope -bqk ; create_TTT'
alias csk_rebuild='cat cscope.files | xargs etags -a ; cscope -bqk ; create_TTT'
alias cs_show='cscope -d -p10 '
alias cs_S='cscope -d -p10 '

#stty erase '^?'

alias byebye='ionice -c 3 nice -n 19 '
alias faster='ionice -c 2 -n 0 '

# Git branch in prompt.
parse_git_branch() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
#export PS1="\u@\h \W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "

#SHELL
export SHELL=/bin/bash

export HISTSIZE=50000
export HISTFILESIZE=10000
export CSCOPE_EDITOR=vim
alias grep='grep --color=auto'
alias colGrep='grep --color=always'
alias peco=' ~/apps/peco/peco '   #added it in /bin/
alias peco_fuzzy=' ~/apps/peco_linux_amd64/peco --initial-filter Fuzzy '
alias fzf=' ~/apps/fzf/fzf '
alias ripgrep='rg --hidden -n'
alias remember='tac ~/.bash_history >> ~/Desktop/hist2 ; sort -u ~/Desktop/hist2 > ~/Desktop/hist ; tac ~/Desktop/hist | peco |  tr -d "\n" | xclip '
# also adding fzf
alias TTT='cat cscope.TTT | fzf --reverse --color=light -i |  tr -d "\n" | xclip '
alias TTTT='cat cscope.TTT | fzf --reverse --color=light -i | tr -d "\n" | xclip '
alias tclip='tr -d "\n" | xclip '
alias lowlow='nice -n 19 '

alias fetch='find * | peco | tr -d "\n" | xclip '
alias catz='lolcat '
alias lolzcat='lolcat -a '
alias show_new='ls -ltha'
alias cd1='cd .. '
alias cd2='cd ../.. '
alias cd3='cd ../../.. '
alias cd4='cd ../../../.. '
alias cd5='cd ../../../../.. '
#alias pwclient='python ~/apps/pwclient'


#alias infer='/home/pascal_06/apps/infer-linux64-v0.15.0/bin/infer'
alias make='ionice -c idle nice -n 19 make'

#wireshark
#alias wiDev='~/apps/wireshark/run/wireshark '
#alias suWiDev='sudo ~/apps/wireshark/run/wireshark '


if [[ -v TMUX ]]
then
	export PS1="\[\033[48;5;2m\]\u@\H\[$(tput sgr0)\]\[\033[38;5;11m\]\$(parse_git_branch)\[\033[48;5;-1m\] \w \\$\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]"
	#fortune | cowsay -f $(ls /usr/share/cowsay/ | shuf -n1) -W80
fi
