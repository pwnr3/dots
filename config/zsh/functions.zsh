# Use lf to switch directories and bind it to ctrl-o
lfcd() {
	tmp="$(mktemp)"
	lf -last-dir-path="$tmp" "$@" # after browsing in lf, save last dir path into $tmp
	if [ -f "$tmp" ]; then
		dir="$(cat "$tmp")"
		rm -f "$tmp" >/dev/null
		[ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
	fi
}
# bindkey -s '^o' 'lfcd\n' bindkey -s '^r' 'cd "$(dirname "$(fzf)")"\n'

# fh - repeat history
# `print -z': push history onto editing buffer, `eval' run history command directly
fh() {
	print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed -E 's/ *[0-9]*\*? *//' | sed -E 's/\\/\\\\/g')
}

# fkill - kill processes - list only the ones you can kill.
fkill() {
    local pid
    if [ "$UID" != "0" ]; then
        pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
    else
        pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
    fi

    if [ "x$pid" != "x" ]
    then
        echo $pid | xargs kill -${1:-9}
    fi
}

# clean up .z file to remove paths no longer valid
zclean() {
	[ ! -f $HOME/.z ] && return
	tmp=$(mktemp /tmp/z.XXXXX)
	while read -r i
	do
		tmpi=$(echo $i | cut -d'|' -f1)
		[ -d $tmpi ] && echo $i >> $tmp
	done < $HOME/.z
	command mv -f $tmp $HOME/.z
}

# abbr pwd
function path_abbr {
	base_pwd=$PWD
	tilda_notation=${base_pwd//$HOME/\~}
	pwd_list=(${(s:/:)tilda_notation})
	list_len=${#pwd_list}

	if [[ $list_len -le 1 ]]; then
		echo $tilda_notation
		return
	fi

	if [[ ${pwd_list[1]} != '~' ]]; then
		formed_pwd='/'
	fi

	firstchar=$(echo ${pwd_list[1]} | cut -c1)
	if [[ $firstchar == '.' ]] ; then
		firstchar=$(echo ${pwd_list[1]} | cut -c1,2)
	fi

	formed_pwd=${formed_pwd}$firstchar

	for ((i=2; i <= $list_len; i++)) do
		if [[ $i != ${list_len} ]]; then

			firstchar=$(echo ${pwd_list[$i]} | cut -c1)
			if [[ $firstchar == '.' ]] ; then
				firstchar=$(echo ${pwd_list[$i]} | cut -c1,2)
			fi

			formed_pwd=${formed_pwd}/$firstchar
		else
			formed_pwd=${formed_pwd}/${pwd_list[$i]}
		fi
	done

	echo $formed_pwd
	return
}

# append less to rg result, keep colored
rgl() {
	rg -p "$@" | less -XFR
}

# Convert Git to Shallow clone
cgs() {
	[ ! -d .git ] && return
	ORIGIN_URL=$(git remote get-url origin)
	COMMIT=$(git rev-parse HEAD)

	rm -rf .git
	git init .
	git remote add origin $ORIGIN_URL
	git fetch origin $COMMIT --depth 1
	git reset --mixed $COMMIT
}
