# install kexts to S/L/E
sudo cp -R KextToInstall.kext /Library/Extensions
sudo touch /System/Library/Extensions && sudo kextcache -u / # check kernel cache
sudo kextcache -i / # shortcut (10.11.x and later)

# check loaded kexts
sudo kextstat

# fix audio no sound after sleep
install codeccommander into S/L and rebuild cache

# check CPU frequency
two tools : MSRDumper.kext AppleIntelInfo.kext
usage :
    sudo kextload XXX.kext
    check /tmp/AppleIntelInfo.dat or "Console"
    sudo kextunload XXX.kext

# flush dns
sudo dscacheutil -flushcache

# power management
pmset -g

# auto wake in sleep
AppleACPIPlatformPower Wake reason: GLAN XDCI

# change shell
make sure your shelll is in /etc/shells

# disk tool
diskutil list

# CPU problem
bak Mac-65CE76090165799A.plist (in S/L/E), it should work well, so before update
remember to store it

# manual mount
diskutil mount /dev/disk1s1
diskutil umount /Volumes/XXXXXX

# disable auto mount
1 use "diskutil info /Volumes/XXX" to get Volume UUID
2 sudo vifs | vim /etc/fstab
3 type "UUID=xxxxxxxxxxxxxxxx none <filesystem-type> rw,noauto"
4 sudo automount -vc # not necessary

# show app-from-any-sources in setting
sudo spctl --master-disable

# uninstall, completely remove application
~/Library/Application Support/<app name>
~/Library/Preferences/<app name>
~/Library/Caches/<app name>

# ioreg
# ioreg -lw0
VendorID=$(ioreg -l | grep "DisplayVendorID" | awk '{print $NF}')
ProductID=$(ioreg -l | grep "DisplayProductID" | awk '{print $NF}')
EDID=$(ioreg -l | grep "IODisplayEDID" | awk '{print $NF}' | sed -e 's/.$//' -e 's/^.//')
Vid=$(echo "obase=16;$VendorID" | bc | tr 'A-Z' 'a-z')
Pid=$(echo "obase=16;$ProductID" | bc | tr 'A-Z' 'a-z')

# brew
brew cask install google-chrome
two install way : cask cellar (/usr/local/Caskroom /usr/local/Cellar)
two related path : /usr/local/Homebrew/Library/Taps/homebrew/homebrew-[core|cask]
brew uninstall xxxx # remove app
brew cleanup # clean out previously downloaded source files
brew doctor # check brew installation is OK
cd "$(brew --repo)" && git fetch && git reset --hard origin/master && brew update

# "brew update" not work after git pull origin master, try following commands
cd `brew --prefix`/Homebrew
git fetch origin
git reset --hard origin/master

# emacs
brew install emacs --with-cocoa --with-gnutls --with-rsvg --with-imagemagick
brew linkapps emacs # link emacs to /Applications folder correctly
                    # deprecated, use cask version instead
brew cask install emacs # now suggested
M-x package-in # check loaded packages
M-:
C-x C-e # eval
# emacs theme customize
M-x load-theme
M-x disable-theme # disable theme
M-x describe-variable + custom-enabled-themes
M-x set-background-color
C-/ and C-_ # terminal can not send C-/ so you should use C-x u or C-_ for "undo", and C--(shift no need pressed) just work

# tex
mactex-basic
installed path : /usr/local/texlive/2018basic
install plugin : sudo tlmgr install xxx
useful info : /usr/local/texlive/2018basic/install-tl.log

# vim h/j/k/l speed
in keyboard setting, set key repeat to fast, delay until repeat to short
or use ^U, ^D, G instead of hjkl when navigating long text

# VoodooPS2Controller caps to left ctrl
# kexts/Other/VoodooPS2Controller.kext/Contents/PlugIns/VoodooPS2Keyboard/Contents/Info.plist
# https://github.com/acidanthera/VoodooPS2/blob/master/VoodooPS2Keyboard/ApplePS2ToADBMap.h
change info.plist 
0x35,   // 01  Escape
0x30,   // 0f  Tab
0x3b,   // 1d  Left Control
0x32,   // 29  `~
0x39,   // 3a  Caps Lock
<string>3a=3b;caps ---> left ctrl</string>
<string>29=3b;`~ ---> Escape</string>
IOKitPersonalities->ApplePS2Keyboard->Platform Profile->Default->Custom PS2 Map/Custom ADB Map
https://www.jianshu.com/p/f853d17d48a1

# show hidden file
defaults write com.apple.finder AppleShowAllFiles --bool true
defaults write com.apple.finder AppleShowAllFiles --bool false
defaults write com.apple.finder AppleShowAllFiles YES
defaults write com.apple.finder AppleShowAllFiles NO

# vim/emacs chinese encoding problem
# in vim, use "set fileencoding" to check what encoding vim is using
# in emacs, use C-h v buffer-file-coding-system, or put mouse on mode line U:--- over 'U'
add into .vimrc
    set fencs=utf8,gb18030,gbk,gb2312,ucs-bom
use following command to specify encoding in Emacs
    C-x <RET> r(revert-buffer-with-coding-system) chinese-gb18030 # C-x <RET> overwriten by smex

# spotlight disable
sudo mdutil -a -i off # "on" to enable
cd /System/Library/CoreServices/
sudo mv Search.bundle/ Search2.bundle/
if Alfred can not search app installed by "brew cask",
add /usr/local/Caskroom to Alfred Preference-Features-Search Scope

# bits/stdc++.h
cd /usr/local/include
mkdir bits
save https://gist.github.com/eduarc/6022859 as stdc++.h here

# setup github
git config --global user.name "Name here"
git config --global user.email "Email here"
git config --global credential.helper osxkeychain # push code with HTTPS
# setup ssh
ssh-keygen -t rsa -C "email@example.com"
please use a strong passphrase for your keys
then add id_rsa.pub content to github
# DS_Store
it is important to add DS_Store to .gitignore
git config --global core.excludesfile ~/.gitignore # exclude this file global
echo .DS_Store >> ~/.gitignore
# when asked for username and passwd while git push
# this happens because you cloned the repo using the default(HTTPS) insteand of SSH
git remote set-url origin git@github.com:username/repo.git

# tmux
<prefix> ?           for help, then use emacs hot keys


# codeforces trick
# check running time and space usage
/usr/bin/time -lp a.out <in >out
gtime -v(--verbose) a.out <in >out # better, get more info, need "brew install gnu-time"


# terminal proxy
export http_proxy=socks5://127.0.0.1:1086
export https_proxy=socks5://127.0.0.1:1086
export all_proxy=socks5://127.0.0.1:1086
unset http_proxy https_proxy

# tlmgr : Remote repository is newer than local
adding "tlmgr option repository ftp://tug.org/historic/systems/texlive/2018/tlnet-final"
before tlmgr install

# checking IP
curl ip.gs
curl cip.cc

# LaTeX support chinese
ctex
cjk
cjkpunct
zhnumber
to compile tex with chinese symbol, should use "xelatex XXX.tex"
all tlmgr installed packages are in "/usr/local/texlive/2019basic/tlpkg/tlpobj"

# readelf and objdump
brew install binutils (provide 'gobjdump' & 'greadelf')
echo 'export PATH="/usr/local/opt/binutils/bin:$PATH"' >> ~/.zshrc

# screenshot
Alt + Shift + 4                 select to capture
Alt + Shift + 3                 full screen-shot
the file is saved to the Desktop

# pwndbg
ROPgadget-5.8 atomicwrites-1.3.0 attrs-19.1.0 backports.functools-lru-cache-1.5 capstone-4.0.1 configparser-3.7.4 contextlib2-0.5.5 enum34-1.1.6 funcsigs-1.0.2 future-0.17.1 futures-3.3.0 importlib-metadata-0.18 isort-4.3.21 more-itertools-5.0.0 packaging-19.0 pathlib2-2.3.4 pluggy-0.12.0 psutil-5.6.3 py-1.8.0 pycparser-2.19 pyelftools-0.25 pygments-2.4.2 pyparsing-2.4.0 pytest-4.6.4 python-ptrace-0.9.3 scandir-1.10.0 six-1.12.0 unicorn-1.0.1 wcwidth-0.1.7 zipp-0.5.2

# .DS_Store
find . -name .DS_Store -type f -delete ; find . -type d | xargs dot_clean

# qq mail
# rhiqtgbelmnbdgec


# docker
docker search ubuntu
docker pull  ubuntu
docker image ls # list installed images
docker run -i -t --name mineos ubuntu bash # interactive, pseudo-tty, container_name, image_name, run_command
docker ps # list running container, "-a" for all containers
docker start/stop mineos
docker start -i mineos # start interactively
docker exec -it <container> bash # multiple terminal
docker commit -m "MESSAGE" -a "COMMIT_USER" CONTAINER_ID NEW_IMAGE_NAME # example: docker commit -m 'add ssh' -a '5km' e5d8c1030724 ubuntu-ssh
# after setup ssh services, use follow command to create new ubuntu container
docker run -d -p 26122:22 --name learn ubuntu-ssh /usr/sbin/sshd -D # daemon, port(host_machine_port:ssh_port), container_name, command+args
ssh -p 26122 root@localhost # use this command to connect container "ubuntu-ssh"

~/Library/Containers/com.docker.docker/Data/vms/0/Docker.raw # stored place

uname -m # check 32/64 bit
# but not in docker container, this command will show host's kernel, so if you fild "x86_64" here, you should use
# "file /bin/bash" or check for the presense of "lib/x86_64-linux-gnu/" or "/lib/i386-linux-gnu"

# ubuntu
# version
cat /etc/issue
cat /etc/lsb-realse
uname -a (kernel version)
cat /proc/version

# vim
Ctrl+C == ESC
# window control
:new # create white window
:vsp(:vsplit) filename
:sp(:split) filename
ctrl+w s(split) # open current file
ctrl+w v(vsplit)
:only | ctrl+w o # only save current window
ctrl+w c(close)
ctrl+w q(quit)
ctrl+w h/j/k/l # move among windows
ctrl+w </>/+/-/= # resize window

# terminal decimal/hex/oct
# example
echo "ibase=10;obase=16;1012" | bc

# vim simple setup
syntax on
set smartindent
set autoindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
# set et sw=4 ts=4 sts=4
set number
set hlsearch # highlight search result

# QQ music mac
http://dldir1.qq.com/music/clntupate/QQMusicMac3.0Build09.dmg

# install emacs manually
brew info emacs # check
brew unlink emacs
brew uninstall emacs
brew install emacs --with-gnutls --with-librsvg --with-cocoa --with-imagemagick@6 --HEAD
# --HEAD/--devel, remove it to install stable version
# --with-modules
# --with-mailutils
brew pin imagemagick@6 emacs
# imagemagick@6 and devel change frequently so exclude them from automatic updates and do updates manually at covient time
brew -v install emacs-plus --without-modules --without-libxml2 --without-little-cms2 --without-multicolor-fonts --without-spacemacs-icon --HEAD --with-emacs-27-branch

# glibc
mkdir glibc-build # create a build directory
cd glibc-build
~/Downloads/glibc-xx/configure --prefix=~/glic-build
make
make install
gcc -g -z norelro -z execstack -o vuln vuln.c -Wl,--rpath=/home/xxx/glibc-build/lib -Wl,--dynamic-linker=/home/xxx/glibc-build/lib/ld-linux.so.2
ldd vuln

# refresh
exec zsh # refresh without restart terminal

# speedup pip
pip install django -i https://pypi.tuna.tsinghua.edu.cn/simple
# or add it to ~/.pip/pip.conf
[global]
index-url=http://mirrors.aliyun.com/pypi/simple/
[install]
trusted-host=mirrors.aliyun.com

# speedup github clone
git clone github.com/xxx/xxx.git
# change to
git clone github.com.cnpmjs.org/xxx/xxx.git
# company npm js = cnpmjs


# vim regular expression
# \v (very magic)
use regex directly # \vpop \w+ ; pop \w+ ; ret
# \m (magic mode,     default enabled)
add a slash before any metacharacter besides "$ . * ^"
# \M (nonmagic)
add a slash before any metacharacter besides "$ ^"

# npm and hexo
npm --registry https://registry.npm.taobao.org install XXX
npm install -g npm # update package/self

# vscode add invisiable folder into workspace
shift + command + .

# dns or raw.githubusercontent.com
114.114.114.114 # 114 dns server (domestic)
8.8.8.8 # google dns server, can access raw.githubusercontent.com, but cannot access baidu (many other china sites can be accessed)
replace 'raw.githubusercontent.com' with 'raw.staticdn.net'

# bios
# c/p state https://metebalci.com/blog/a-minimum-complete-tutorial-of-cpu-power-management-c-states-and-p-states/      github/CoreFreq - CPU monitor
# source: https://github.com/zearp/OptiHack/blob/master/text/BIOS_STUFF.md
amibcp # bios unlock tool for American Megatrends, change Default under "Access/Use" to USER
H2OUVE # hex editing bios, replace bytes flow (e.g, change power from 220W to 330W by replacing 220000 with 330000 )
fptw64.exe -bios -d bak.bin # backup bios to bak.bin,       -bios: only bios region
fptw64.exe -bios -f new.bin # flash bios from new.bin
fptw64.exe -me -f mod_bios.bin # flash ME region
fptw64.exe -greset # run after flashing, not seen from most guide
afuwinx64.exe # write bios with GUI?
change logo # a tool that work as its name says
