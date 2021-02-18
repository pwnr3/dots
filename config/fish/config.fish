#!/usr/bin/fish

if status is-interactive
	# source ~/.config/fish/path.fish
	# source ~/.config/fish/alias.fish

	test -d ~/.local/bin && set PATH $PATH (find ~/.local/bin -type d -printf %p:)
	test -r /usr/share/z/z.sh && /bin/bash /usr/share/z/z.sh
	
	# export XDG_CONFIG_HOME=$HOME/.config
	
	alias ssr 'set -gx https_proxy socks5://127.0.0.1:1086; set -gx http_proxy socks5://127.0.0.1:1086; sudo python /shadowsocksr/shadowsocks/local.py -c /shadowsocksr/user-config.json -d start'
	alias unssr 'set -e https_proxy; set -e http_proxy; sudo python /shadowsocksr/shadowsocks/local.py -c /shadowsocksr/user-config.json -d stop'
	alias l 'ls -la'
end
