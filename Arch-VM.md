* where is autoload man page
	autoload isn't in bash but in zsh/ksh
	`man zshbuiltins`, `man zshmodules`, `man zshcompsys`
	example: `autoload -Uz vcs_info`, -z means zsh(rather than ksh) style
* run command stored in variable
* key remap
	xmodmap -pke
	xev: print x event
* 32 bit support
	comment out [multilib] in pacman.conf
	pacman -S lib32-glibc lib32-gcc-libs

# SHELL
* when having trouble with bash script syntax, searching "bash script cheatsheet"
:view a
	cmd=(ls -l) =====> $cmd
	cmd='ls -l' =====> $=cmd
* special variable in shell
	$0 - current script name(special kind of $n)
	$n - the nth argument, e.g. $1 -> first argument, 2nd -> second argument
	$# - number of arguments, except $0
	$* - all arguments, expands to a single argument with all elements delimited by space
	$@ - all arguments, expands to multiple arguments
	$? - return code
	$$ - current process id

# git
* git rebase
	1. make linear commit history (compare with 'git merge')
	2. git rebase -i HEAD~~ (interactively rebase, squash history commit)

# vim

* text object (used in vim-surround or smart select in VISUAL mode)
	[number]<command>[text object or motion]
	i			inner block (e.g. 'hel|lo world', '|' is the cursor position, diw --> ' world')
	a			a block, including blank after (e.g., 'hel|lo world', daw --> world, blank deleted too)
	w/W		word/WORD (same as below)
	s			sentence
	p			paragraph
	t			tag
	example:
		di(					delete all stuff in ()
		cit					delete all stuff between tag(in html), start editing
		viw					quick select word
* quick navigation
	dt{c}				delete until meet {c}
	f{c}				move to next {c}, use ; to repeat, use , to repeat opposite
	t{c}				till next{c}, with ; ,
	^O					(insert mode) (Not INSERT), can use command of Normal mode one time without go into Normal mode
* v(Visual) / V(V-line) / C-V(V-block)
* :num - go to line <num>
* select multi lines
	method 1: V[num]G - select line from current to line <num>
	method 2: 1)m + a (mark current line as a); 2)go to another line, V+`+a to select lines between this and a
* "+ --> system clipboard register
	"% --> current filename
	". --> last inserted content
	"0 --> copy register
	"" --> unamed register, check with (help "")
	:reg "+
* macro
	without: select multi line, input ':normal A,', this can add ',' to those selected lines
	using macro:
		use 'qa' to record macro into register a
		appending ',' at the end of line with 'A ,', press 'q' to stop recording
		select multi lines, run ':normal @a'

	adding increasing number
		(Normal) :let i=1 -> qa -> (Insert) ^R=i -> (Normal) :let i+=1 -> q
* replace
	:% s/old/new/g				% --> current file, g --> global
* '[' and ']': special command for jumping (check with :help [)
* 'xp' : swap current character with the next one
* vim --startuptime /tmp/vim.log

















# add
* python -m ensurepip
* after I upgrade from python3.8 to python3.9, virtualenv fail, it use python3.9 rather than old python3.8(arch remove old and install
new version), everything in virtual environment fail to work, pip also upgrade for python3.9..........gdb (compiled with python3.8)
fail to load libpython3.8.so and cannot work either.
* fail to start docker.service after installing ------------ need a reboot
* docker
	sudo groupadd docker(may be skipped)
	sudo gpasswd -a <user name> docker
	newgrp docker (must do this or you still cannnot run docker command for permission deny)
	check with command "groups" and you will find your username is under docker (without newgrp command will not work)
