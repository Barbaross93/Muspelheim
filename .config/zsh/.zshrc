## ▒███████ ████████░ ██ ██▀███ ▄████▄  
## ▒ ▒ ▒ ▄▒██    ▓██░ ██▓██ ▒ █▒██▀ ▀█  
## ░ ▒ ▄▀▒░ ▓██▄ ▒██▀▀██▓██ ░▄█▒▓█    ▄ 
##   ▄▀▒    ▒   █░▓█ ░██▒██▀▀█▄▒▓▓▄ ▄██ 
## ▒██████▒██████░▓█▒░██░██▓ ▒█▒ ▓███▀  
## ░▒▒ ▓░▒▒ ▒▓▒ ▒ ▒ ░░▒░░ ▒▓ ░▒░ ░▒ ▒   
## ░░▒ ▒ ░░ ░▒  ░ ▒ ░▒░ ░ ░▒ ░ ▒ ░  ▒   
## ░ ░ ░ ░░  ░  ░ ░  ░░ ░ ░░   ░        
##   ░ ░        ░ ░  ░  ░  ░   ░ ░      
## ░                           ░        

### Zsh specific settings
# Completion
autoload -Uz compinit
compinit
unsetopt completealiases
zstyle ':completion:*' rehash true

## Nifty third party tools
#import nifty gitstatus tool
source ~/.config/zsh/gitstatus/gitstatus.plugin.zsh
# Startup zoxide
eval "$(zoxide init zsh)"

# General opts
setopt autocd
unsetopt beep notify
bindkey -e
zstyle :compinstall filename '/home/barbaross/.config/zsh/.zshrc'

# History opts
HISTFILE=~/.config/zsh/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt EXTENDED_HISTORY
setopt SHARE_HISTORY

# Colors for prompt
autoload -U colors && colors

# Make home/end/del keys work properly
bindkey  "^[[7~"   beginning-of-line
bindkey  "^[[1~"   beginning-of-line
bindkey  "^[[8~"   end-of-line
bindkey  "^[[4~"   end-of-line
bindkey  "^[[3~"   delete-char
bindkey  "^[[5~"   up-line-or-history
bindkey  "^[[6~"   down-line-or-history

# Autosuggestions and syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
#source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

# Key bindings for history substring search
#bindkey '^[[A' history-substring-search-up
#bindkey '^[[B' history-substring-search-down

# Setup fzf
source /usr/share/fzf/key-bindings.zsh

# Setup thefuck
#eval $(thefuck --alias)
#fuck-command-line() {
#    local FUCK="$(THEFUCK_REQUIRE_CONFIRMATION=0 thefuck $(fc -ln -1 | tail -n 1) 2> /dev/null)"
#    [[ -z $FUCK ]] && echo -n -e "\a" && return
#    BUFFER=$FUCK
#    zle end-of-line
#}
#zle -N fuck-command-line
## Defined shortcut keys: [Esc] [Esc]
#bindkey -M emacs '\e\e' fuck-command-line
#bindkey -M vicmd '\e\e' fuck-command-line
#bindkey -M viins '\e\e' fuck-command-line

# Style completion menu
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==35=35}:${(s.:.)LS_COLORS}")';
zstyle ':completion:*:descriptions' format $'\e[01;33m %d\e[0m'
zstyle ':completion:*:messages' format $'\e[01;31m %d\e[0m'

## Prompt stuff
# Helper functions for prompt
# determine cursor position to either start with/out newline
cup(){
  echo -ne "\033[6n" > /dev/tty
  read -t 1 -s -d 'R' line < /dev/tty
  line="${line##*\[}"
  line="${line%;*}"
  echo "$line"
}

# Preexec function
setup() {
	# Change window title to current command right after command is inputted
	print -Pn "\e]0;$1\a"
}

# Classy touch inspired prompt
custom_prompt() {
	cmd_cde=$?
	# Set window title
	print -Pn "\e]2;%n@%M: %~\a"
	if [ $(cup) -eq 1 ]; then
		PROMPT=""
	else
		PROMPT=$'\n'
	fi
	PROMPT+="%{$fg[red]%}┏━"
	[ "$(id -u)" -eq 0 ] && PROMPT+="[%{$fg[white]%}root%{$fg[red]%}]%{%G━%}"
	PROMPT+="[%{$fg[white]%}%~%{$fg[red]%}]"

	if gitstatus_query MY && [[ "$VCS_STATUS_RESULT" == ok-sync ]]; then
		if [[ -n "$VCS_STATUS_LOCAL_BRANCH" ]]; then
			PROMPT+="%{%G━%}[%{$fg[white]%}${${VCS_STATUS_LOCAL_BRANCH:-@${VCS_STATUS_COMMIT}}//\%/%%}" # escape backslash
		else
			PROMPT+="%{%G━%}%{$fg[white]%}@${${VCS_STATUS_COMMIT}//\%/%%}" # escape backslash
		fi
		(( VCS_STATUS_HAS_STAGED )) && PROMPT+=' +'
		(( VCS_STATUS_HAS_UNSTAGED )) && PROMPT+=' !'
		(( VCS_STATUS_HAS_UNTRACKED )) && PROMPT+=' ?'
		PROMPT+="%{$fg[red]%}]"
	fi

	if [ $cmd_cde -eq 0 ]; then
		PROMPT+=$'\n'"%{$fg[red]%}┗━━ %{$fg_bold[black]%}■ %{$reset_color%}"
	else
		PROMPT+=$'\n'"%{$fg[red]%}┗━━ %{$reset_color%}■ "
	fi
	
	setopt no_prompt_{bang,subst} prompt_percent  # enable/disable correct prompt expansions
}

gitstatus_stop 'MY' && gitstatus_start -s -1 -u -1 -c -1 -d -1 'MY'
autoload -Uz add-zsh-hook
add-zsh-hook preexec setup
add-zsh-hook precmd custom_prompt
export PROMPT2="%{$fg_bold[black]%} %{%G■%}%{$reset_color%} "

### General configs
# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
	export EDITOR='vim'
fi

# Color support for ls, fd, etc
eval $(dircolors -p | perl -pe 's/^((CAP|S[ET]|O[TR]|M|E)\w+).*/$1 00/' | dircolors -)

# Pfetch configuration
export PF_INFO="ascii title os host kernel wm pkgs shell editor palette"

### Aliases
alias svim='sudoedit'
alias weather="curl 'wttr.in/?T'"
alias li="exa --icons"
alias l="exa -la"
alias ip="ip --color=auto"
alias diff='diff --color=auto'
alias clip="xsel -ib"
alias cat="bat -p"
alias pfetch="curl -s https://raw.githubusercontent.com/dylanaraps/pfetch/master/pfetch | sh"
alias ls="exa"
alias cs="compsize"
alias scan="scanimage --device 'hpaio:/net/OfficeJet_3830_series?ip=192.168.0.13' --progress --format=png --output-file"
alias cp="cp --reflink" #to make lightweight copies w/ btrfs
# avoid typing the whole thing
alias halt="sudo halt"
alias poweroff="sudo poweroff"
alias reboot="sudo reboot"
alias shutdown="sudo shutdown"
alias zzz="sudo zzz"
alias ZZZ="sudo ZZZ"
alias xr="sudo xbps-remove -Rcon"
alias xc="sudo xbps-remove -Oo"
alias xu='sudo xbps-install -Suv'
alias xl='xbps-query -l'
alias xf='xbps-query -f'
alias xd='xbps-query -x'
alias xm='xbps-query -m'
alias xs='fuzzypkg'
alias clk='sudo vkpurge rm all'
alias tksv='tmux kill-server'
alias hc='herbstclient'
alias pyratehole="lynx gopher://g.nixers.net/1/~pyratebeard/music/this_week.txt"
alias dotlink="stow -R --target=/home/barbaross -d /home/barbaross/Public/thonkpad-dotfiles ."
alias spotdl="cd ~/Music && pipx run spotdl"
alias sshpi="ssh -p 5522 barbaross@192.168.0.2"
alias trp="trash-put"
alias trr="trash-restore"
alias tre="trash-empty"
#alias ovpn="sudo openvpn --config /etc/openvpn/client/barbarossaOvpn.ovpn --askpass /etc/openvpn/barbarossOvpn.pass --daemon"
#alias kovpn="sudo pkill -INT openvpn"
alias wgu="sudo wg-quick up barbarossvpn"
alias wgd="sudo wg-quick down barbarossvpn"
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....="cd ../../../.."
alias _="sudo"
#alias mntmsc="sshfs pi@192.168.0.2:/var/www/html ~/Music"
#alias vit="pipx run vit"
alias cmus='tmux new-session -s Music "tmux source-file ~/.config/cmus/tmux_session"'
alias newsboat='newsboat -q'

### Functions

# Colorized man pages
man() {
	env \
		LESS_TERMCAP_mb=$(printf "\e[1;31m") \
		LESS_TERMCAP_md=$(printf "\e[1;31m") \
		LESS_TERMCAP_me=$(printf "\e[0m") \
		LESS_TERMCAP_se=$(printf "\e[0m") \
		LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
		LESS_TERMCAP_ue=$(printf "\e[0m") \
		LESS_TERMCAP_us=$(printf "\e[1;32m") \
		man "$@"
}

# Hit Q in order to get out of ranger in the directory you're in
r() {
	local IFS=$'\t\n'
	local tempfile="$(mktemp -t tmp.XXXXXX)"
	local ranger_cmd=(
		command
		ranger
		--cmd="map Q chain shell echo %d > $tempfile; quitall"
	)

	${ranger_cmd[@]} "$@"
	if [[ -f "$tempfile" ]] && [[ "$(cat -- "$tempfile")" != "$(echo -n $(pwd))" ]]; then
		cd -- "$(cat "$tempfile")" || return
	fi
	command rm -f -- "$tempfile" 2>/dev/null
}

# ls after a cd
cl() {
	local dir="$1"
	local dir="${dir:=$HOME}"
	if [[ -d "$dir" ]]; then
		cd "$dir" >/dev/null
		ls
	else
		echo "bash: cl: $dir: Directory not found"
	fi
}

# one off calculator
calc() {
	echo "scale=3;$@" | bc -l
}

# Cht query
cht() {
	curl -s "cheat.sh/$(echo -n "$*" | jq -sRr @uri)"
}
