# Pass selected files as arguments to the given command
# Usage: f echo
# Usage: f vim
f() {
  IFS=$'\n'
  files=($(fd . --type f --type l "${@:2}" | fzf -0 -1 -m))
  IFS=$' '
  [[ -n "$files" ]] && eval $1 "${files[@]}" # add eval to fix alias parameter problem
}

# Pass selected directories as arguments to the given command
# Usage: d ws
d() {
  IFS=$'\n'
  dirs=($(fd . --type d "${@:2}" | fzf -0 -1 -m))
  IFS=$' '
  [[ -n "$dirs" ]] && eval $1 "${dirs[@]}"
}


# # Open the selected files with selected editor
# #   - CTRL-O to open with `open` command
# #   - CTRL-E to open with VSCode
# #   - CTRL-W to open with WS
# #   - Enter (default) to open with $EDITOR
fe() {
  local out files key
  IFS=$'\n'
  out=("$(fzf-tmux --query="$1" --multi --exit-0 --expect=ctrl-o,ctrl-e,ctrl-w)") # not edit in new pane but show fzf result in split pane
  key=$(head -1 <<< "$out")
  files=($(tail -n +2 <<< "$out"))
  if [ -n "$files" ]; then
    if [ "$key" = ctrl-o ]; then lf "${files[@]}"; # customize to open with 'lf/ranger'
    elif [ "$key" = ctrl-w ]; then ws "${files[@]}";
    elif [ "$key" = ctrl-e ]; then code "${files[@]}";
    else ${EDITOR} "${files[@]}";
    fi
  fi
}

# fcd - cd to selected directory
# Similar to default ALT+C fzf key binding
fcd() {
  local dir
  dir=$(fd --type d --follow . ${1:-.} | fzf +m) && cd "$dir"
}

# cd to selected parent dir
cdp(){
  local declare dirs=()
  get_parent_dirs() {
    if [[ -d "${1}" ]]; then dirs+=("$1"); else return; fi
    if [[ "${1}" == '/' ]]; then
      for _dir in "${dirs[@]}"; do echo $_dir; done
    else
      get_parent_dirs $(dirname "$1")
    fi
  }
  local DIR=$(get_parent_dirs $(dirname "$(realpath "$PWD")") | fzf-tmux)
  cd "$DIR"
}

# # Integration with z
# # like normal z when used with arguments, but displays an fzf prompt when used without.
unalias z 2> /dev/null
z() {
  [ $# -gt 0 ] && _z "$*" && return
  cd "$(_z -l 2>&1 | fzf --height 40% --nth 2.. --reverse --inline-info +s --tac --query "${*##-* }" | sed 's/^[0-9,.]* *//')"
}

# Search with ripgrep and show matches in fzf
# Usage frg <query>
frg() {
  if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi

	local rg_command=(rg --hidden --column --line-number --no-heading --color=always --smart-case $*)
  selection=$(($rg_command || true) | fzf +m --ansi \
    --preview-window="right:wrap" --preview "$HOME/.config/nvim/plugged/fzf.vim/bin/preview.sh {}")
  if [[ -n "$selection" ]]; then
    local file=$(echo $selection | awk -F: '{ print $1 }')
    local line=$(echo $selection | awk -F: '{ print $2 }')
    local column=$(echo $selection | awk -F: '{ print $3 }')
    vim "+call cursor($line, $column)" "$file"
  fi
}
# Search with ripgrep, list matching files in fzf
# Usage: frgl <query>
frgl() {
  local file
  if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
  file=$(rg --files-with-matches --no-messages "$1" | fzf +m --preview-window="right:wrap" --preview "bat --style=numbers --color=always {} 2> /dev/null | rg --color always --colors 'match:bg:yellow' --context 10 '$1' || rg --color always --context 10 '$1' {}")
  if [[ -n "$file" ]]; then
    $EDITOR "$file"
  fi
}
# Search with ripgrep with live query reload
# Query can be changed on a fly and will spawn rg command once again instantly
# fzf disables its fuzzy find features, and acts as a dumb selector
# error: rg --hidden ... command not found but run well, throw error output
# Usage: frgi <query>
frgi() {
  local rg_command="rg --hidden --column --line-number --no-heading --color=always --smart-case"
  local query="$1"
  selection=$(($rg_command '$query' 2> /dev/null || true ) | \
    fzf +m --bind "change:reload:$rg_command {q} || true" --ansi --disabled --query "$query" \
      --preview-window="right:wrap" --preview "$HOME/.config/nvim/plugged/fzf.vim/bin/preview.sh {}")
  if [[ -n "$selection" ]]; then
    local file=$(echo $selection | awk -F: '{ print $1 }')
    local line=$(echo $selection | awk -F: '{ print $2 }')
    local column=$(echo $selection | awk -F: '{ print $3 }')
    vim "+call cursor($line, $column)" "$file"
  fi
}


# Open rg search results in a Vim "quickfix" list
rgq() {
  vim -q <(rg --column --no-heading $*)
}
