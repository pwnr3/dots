[[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh
source $HOME/.config/zsh/env.zsh
source $ZDOTDIR/aliases.zsh
# source $ZDOTDIR/vi.zsh
source $ZDOTDIR/fzf.zsh
# source $ZDOTDIR/fzf_completion.zsh
# source $ZDOTDIR/fzf_keybindings.zsh
source $ZDOTDIR/functions.zsh
# source $ZDOTDIR/git.zsh

# Auto complete
if [ -z "$ZSH_COMPDUMP" ]; then
  ZSH_COMPDUMP="${ZDOTDIR:-${HOME}}/.zcompdump"
fi
autoload -U compinit
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*' # completion before '._-', e.g. f.b -> foo.bar
zmodload zsh/complist
if [[ -f $ZSH_COMPDUMP ]]; then
	compinit -C
else
	compinit -d "$ZSH_COMPDUMP"
fi
_comp_options+=(globdots)	# Include hidden files


# PROMPT='%(?.%F{green}√.%F{red}?%?)%f %B%F{240}%1~%f%b %# ' # problem when using tab
# RPROMPT='%*'
setopt PROMPT_SUBST # needed for zsh, check `man zshall' in `PROMPT EXPANSION'
export PS1="%B%F{240}\$(path_abbr)%f%b %(!.#.>) "


#========================================
# Extra
#========================================
set -o emacs # don't know why vi mode is turn on default though getting *off* with `set -o | rg vi'
tabs 4 # or `cat test.c | expand -t4'

setopt auto_cd # Automatically cd
unsetopt equals # so [ a == b ] works, otherwise only [[ a == b ]] works
[[ $- == *i* ]] && stty -ixon # free up <C-s/C-q> shortcuts, do this only for interactive shell
# eval "$(direnv hook zsh)" # hook direnv, source local .envrc when entering directory

# Define how zsh handles escape sequences produced by terminal emulator
# bindkey "\e[1~" beginning-of-line
# bindkey "\e[4~" end-of-line
# bindkey "\eOH" beginning-of-line
# bindkey "\eOF" end-of-line

bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down
# bindkey -M vicmd 'k' history-substring-search-up
# bindkey -M vicmd 'j' history-substring-search-down

#========================================
# Plugin
#========================================
source $ZDOTDIR/zsh-history-substring-search.zsh # https://github.com/zsh-users/zsh-history-substring-search
