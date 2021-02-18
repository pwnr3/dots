# export make variable available to sub-process
# [ -d $HOME/.local/bin ] && export PATH="$PATH:$(find $HOME/.local/bin -type d -printf %p:)"
[ -z "$XDG_CONFIG_HOME" ] && export XDG_CONFIG_HOME="${HOME}/.config"
export ZDOTDIR="${XDG_CONFIG_HOME:-${HOME}/.config}/zsh"
[[ ! $PATH =~ "$XDG_CONFIG_HOME/scripts" ]] && export PATH="$PATH:./node_modules/.bin:${$(find $XDG_CONFIG_HOME/scripts -type d -printf %p:)%%:}"
# or [[ ! $PATH == *"XDG_CONFIG_HOME/scripts"* ]] && ...

export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE="${HOME}/.zsh_history"
setopt HIST_EXPIRE_DUPS_FIRST # check with `setopt', http://zsh.sourceforge.net/Doc/Release/Options.html#History
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS

export EDITOR="nvim"
export SUDO_ASKPASS='/usr/lib/ssh/x11-ssh-askpass' # sudo in neovim, need package 'x11-ssh-askpass'
export PAGER="less"
export LESS='-F -i -J -M -R -W -x4 -X -z-4'
# or in long, LESS='--quit-if-one-screen --ignore-case --status-column --LONG-PROMPT --RAW-CONTROL-CHARS --HILITE-UNREAD --tabs=4 --no-init --window=-4'

# export CLICOLOR=1 # enable LS colored output(may be for unix), not needed on ArchLinux
eval $(dircolors -b "$ZDOTDIR/dircolors")
# zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# export PS_FORMAT="pid,ppid,user,pri,ni,vsz,rss,pcpu,pmem,tty,stat,args" # ps
export FD_OPTIONS="--hidden --follow --exclude .git --exclude node_modules" # fd, (--ignore-file $XDG_CONFIG_HOME/.ignore)
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/.ripgrep"
export FZF_DEFAULT_OPTS="
	--no-mouse --height 80% --reverse --multi --info=inline
	--preview='highlight -O ansi -l {} 2> /dev/null | rg --colors \"match:bg:yellow\" --ignore-case --pretty --context 10 \"$1\" || rg --ignore-case --pretty --context 10 \"$1\" {}'
	--preview-window='right:60%:wrap'
	--bind='f2:toggle-preview,f3:execute(bat --style=numbers {} || less -f {}),f4:execute($EDITOR {}),alt-w:toggle-preview-wrap,ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-y:execute-silent(echo {+} | pbcopy),ctrl-x:execute(rm -i {+})+abort,ctrl-l:clear-query'"
export FZF_DEFAULT_COMMAND="git ls-files --cached --others --exclude-standard 2>/dev/null || fd --type f --type l $FD_OPTIONS"
# export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# export FZF_ALT_C_COMMAND="fd --type d $FD_OPTIONS"
# export FZF_TMUX_OPTS='-p80%,60%'

# export _JAVA_AWT_WM_NONREPARENTING=1
