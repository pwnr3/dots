alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

command -v nvim >/dev/null && alias vim='nvim' vimdiff='nvim -d'
alias e='tmux split-window -h "$EDITOR"' # single quote: e-->$EDITOR; double quote: e-->nvim (both work)
# alias v='vim $(fzf)' # same as fe, but cancel(C-c) will enter a empty vim window


alias ls="ls --color=auto --group-directories-first --dereference-command-line-symlink-to-dir"
alias l='ls -CFa'
alias ll='ls -alF'
alias llh='ls -alFh'
alias lld='ls -Gal --color=always | grep ^d --colour=never'

alias tree='tree -F --dirsfirst -a -I ".git|.hg|.svn|__pycache__|.mypy_cache|.pytest_cache|*.egg-info|.sass-cache|.DS_Store" --ignore-case'

alias ga='git add'
# alias gai='git add -i'
# alias gap='git add -p'
alias gb='git branch'
alias gc='git checkout'
alias gcb='git checkout -b'
alias gcd='cd "$(git rev-parse --show-toplevel)"'
alias gd='git diff'
alias gds='git diff --cached'
alias gfl='git fetch --prune && git lg -15'
alias gf='git fetch --prune'
alias gfa='git fetch --all --tags --prune'
alias gl='git lg -15'
alias gll='git lg'
alias gld='git lgd -15'
# alias glf='git-foresta --all --style=10 | less -RSX'
alias gm='git commit -m'
alias gs='git status -sb'

alias dk=docker-compose
alias dps='docker ps --format "table {{.Names}}\\t{{.Image}}\\t{{.Status}}\\t{{ .Ports }}\\t{{.RunningFor}}\\t{{.Command}}\\t{{ .ID }}" | cut -c-$(tput cols)'
alias dls='docker ps -a --format "table {{.Names}}\\t{{.Image}}\\t{{.Status}}\\t{{ .Ports }}\\t{{.RunningFor}}\\t{{.Command}}\\t{{ .ID }}" | cut -c-$(tput cols)'
alias dim='docker images --format "table {{.Repository}}\\t{{.Tag}}\\t{{.ID}}\\t{{.Size}}\\t{{.CreatedSince}}"'
alias dip='docker inspect -f "{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}"'
alias dgc='docker rmi $(docker images -qf "dangling=true")'
alias dvc='docker volume ls -qf dangling=true | xargs docker volume rm'
alias dtop='docker stats $(docker ps --format="{{.Names}}")'
alias dnet='docker network ls && echo && docker inspect --format "{{\$e := . }}{{with .NetworkSettings}} {{\$e.Name}}
{{range \$index, \$net := .Networks}}  - {{\$index}}	{{.IPAddress}}
{{end}}{{end}}" $(docker ps -q)'
alias dtag='docker inspect --format "{{.Name}}
{{range \$index, \$label := .Config.Labels}}  - {{\$index}}={{\$label}}
{{end}}" $(docker ps -q)'

alias fd="fd $FD_OPTIONS" # single quote will fail, double quote will evaluate before alias creation
alias ps='ps -ef'
alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'
alias ssr='sudo python /shadowsocksr/shadowsocks/local.py -c /shadowsocksr/user-config.json -d start'
alias unssr='sudo python /shadowsocksr/shadowsocks/local.py -c /shadowsocksr/user-config.json -d stop'
alias son='export https_proxy=socks5://127.0.0.1:1086; export http_proxy=socks5://127.0.0.1:1086'
alias soff='unset https_proxy http_proxy'

alias gdb='gdb -q'
alias gdbon='echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope'
alias gdboff='echo 1 | sudo tee /proc/sys/kernel/yama/ptrace_scope'
alias ssc='sudo systemctl'
alias sbcl='rlwrap sbcl'
alias brave='brave --incognito --password-store=/tmp/bravepass'
alias sbrave='brave --proxy-server="socks5://127.0.0.1:1086"'
