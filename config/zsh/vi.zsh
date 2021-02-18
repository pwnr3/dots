# check with 'set -o | rg vi', toggle with 'set -o vi/novi'
bindkey -v # vim mode
KEYTIMEOUT=1

bindkey -M vicmd h vi-backward-char
bindkey -M vicmd j vi-down-line-or-history
bindkey -M vicmd k vi-up-line-or-history
bindkey -M vicmd l vi-forward-char
# bindkey -M vicmd v edit-command-line # unhandled ZLE widget 'edit-command-line'

# change cursor shape for different mode
function zle-keymap-select () {
	case $KEYMAP in
		vicmd)			echo -ne '\e[1 q';;	#block
		viins|main)	echo -ne '\e[5 q';;	#beam
	esac
}
zle -N zle-keymap-select
zle-line-init () {
	zle -K viins # initiate `vi insert' as keymap (can be removed if `bindkey -V' has been set elsewhere)
	echo -ne '\e[5 q'
}
zle -N zle-line-init
echo -ne '\e[5 q'	# use beam shape cursor on startup
preexec() { echo -ne '\e[5 q' ;} # use beam shape cursor for each new prompt
