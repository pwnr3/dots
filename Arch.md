# Setup
* downgrade
	pacman -U https://archive.archlinux.org/packages/.....
* where is autoload man page
	autoload isn't in bash but in zsh/ksh
	`man zshbuiltins`, `man zshmodules`, `man zshcompsys`
	example: `autoload -Uz vcs_info`, -z means zsh(rather than ksh) style
* wireless
	iwd cannot find my wifi device and uninstalling iwd makes my wifi device disappear
	(no, it actuall change device name to wlan0) check with 'dmesg | rg wifi', find "wlp3s0: renamed from wlan"
	load coresponding module - iwlwifi, load module with "modprobe"

	iwctl
	station wlan0 show
	station wlan0 scan
	station wlan0 connect xxxxx
	if you connect successfully but have not workwork, enable DHCP by
		1. start dhcpcd service (in this way, sometimes you need to reboot to make it work)
		2. echo "[General]\nEnableNetworkConfiguration=true" > /etc/iwd/main.conf for a dhcp-iwd-client

	nmcli device wifi list
	nmcli device wifi connect <SSID/BSSID> password <password>
	nmcli device wifi connect <SSID/BSSID> password <password> hidden yes # connect to a hidden wifi
	nmcli device wifi connect <SSID/BSSID> password <password> ifname wlan1 <profile_name> # connect on *wlan1* interface
	nmcli device disconnect ifname eth0
	nmcli connection show
	nmcli connection up <name/uuid> # activate
	nmcli connection delete <name/uuid>
	nmcli device
	nmcli radio wifi off # turn wifi off
	nmcli connection edit <connection name>
* aria2
	pacman -Sp <package> | aria2c -i -
	aria2c -UMozilla/5.0 https://usrl/file.xyz # change User Agent
* systemctl list-unit-files/list-units
* watch -n.3 "cat /proc/cpuinfo | grep \"^[c]pu MHz\""


# SHELL
* when having trouble with bash script syntax, searching "bash script cheatsheet"
* run command stored in variable
:view a
	cmd=(ls -l) =====> $cmd
	cmd='ls -l' =====> $=cmd
* key remap
	xmodmap -pke
	xev: print x event
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
* "undo" all uncommitted changes: git add . && git stash && git stash drop (or git stash -u && git stash drop)
* also remove untracked file: git clean -fdx

# vim

* neovim sometimes stuck after editing init.vim (auto reloading), neovim bug or machine/config problem?
	vimscript sucks, hard to write efficient code
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
	^e					scroll line downwards
	^y					scroll line upwards
	^^					open previous open file (like e#)
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
* gf				open in same window
	<c-w>f		open in new window
	<c-w>gf		open in new tab
	use C-O to jump back, use C-I(same as TAB, occupied by nerdtreetoggle) to jump forward
	or use C-^ to open previous open file, which can work backward and forward (same as :e#)
* buffer
	:ls									like ':buffers', list all buffers
	:bd/bw							kill buffer. bd remains the jump list, so 'C-O' will work, while bw(wipeout) not
	:[vertical ]sb#			open buffer in [vertical] split window with specific buffer number
	:b#									switch to buffer #, # is a number


# python
* python -m ensurepip (disabled on Debian)
* python -m venv myenv (create virtualenv without python-pip but need python-venv(which is smaller than former one))
* after pugrading python3.8 to python3.9, virtualenv fails on environment. Need to install all packages for new python
cause they have different path

# docker
* running on non-root user
	sudo groupadd docker(can be skipped)
	sudo gpasswd -a <user name> docker
	newgrp docker (refresh group info, or you still cannot get permission, check with "groups")
* docker fail startup, service start limit hit
	systemctl reset-failed docker.service (not working)
	maybe caused by a kernel/module reloading (raised by system update)
	one solution (seems the only one for me): reboot (start docker.service before applying system update)

	***TODO***
	may have something to do with /var/lib/docker (/var/lib is used to store application data), also have an eye on /var/run/docker (soft link to /run)
	/usr/lib/systemd/system/docker.service

# Hotkey
	+ **scrollback** with `alt-↑/↓` or `alt-pageup/down` or `shift` while scrolling the mouse
	+ OR **vim-bindings**: scroll up/down in history with `alt-k` and `alt-j`. Faster with `alt-u`/`alt-d`.
	+ **zoom/change font size**: same bindings as above, but holding down shift as well. `alt-home` returns to default
	+ **copy text** with `alt-c`, **paste** is `alt-v` or `shift-insert`

# Sandbox
	* virtualbox/vmware
		simple, also useful for windows reverse engineering/Gaming
		may be the best choice, but need to start up virtual machine every time, even if you just need a small windows app
		after install, 'modprobe -a vmw_vmci vmmo', start 'vmware-networks.service' and 'vmware-usbarbitrator.service'
		**stop upgrading** by adding vmware-workstation to /etc/pacman.conf (man pacman.conf), manually add all dependencies in?
		**WHY** need disable updating?? it's safe to keep it newest.
		use 'pacman -Si vmware-workstation' to view dependencies
		pacman -Si <package> | sed -n '/Depends\ On/,/:/p' | sed '$d' | cut -d: -f2 (but not all packages to be installed)
		pacman -Sdd vmware-workstation (skip all dependencies)
	* chroot + busybox + (install wine in it because wine has large and complex dependencies)
		chroot (https://duksctf.github.io/2017/03/15/Make-IDA-Pro-Great-Again.html)
		debootstrap - Debian
		arch-bootstrap - Arch linux - github.com/tokland/arch-bootstrap
		alphie-bootstrap
			wget http://dl-cdn.alpinelinux.org/alpine/v3.12/main/$(arch)/apk-tools-static-2.10.5-r1.apk
			tar zxf apk-tools-static-*.apk
			sudo ./sbin/apk.static --arch $(arch) -X http://dl-cdn.alpinelinux.org/alpine/latest-stable/main/ -U --allow-untrusted --root /tmp/target --initdb add alpine-base

	* wine (for IDA)
		http://brdgr.cn/posts/run-ida7-5-using-wine/
	* wine + docker
		google "install IDA pro under wine in Docker"
	* wine + sandbox ==> flatpak
		pacman -S flatpak
		flatpak remote --add --if-not-exists flaghub https://flathub.org/repo/flaghub.flatpakrepo
		flagpak install flathub com.valvesoftware.Steam
		(can also combine with deepin-wine, https://gitee.com/wsgalaxy/flatpak-deepinwine-wiki)

# Misc
	* github
		git config --global url.https://github.com.cnpmjs.org/.insteadof https://github.com
		git config --global http.proxy socks5://127.0.0.1:1086
