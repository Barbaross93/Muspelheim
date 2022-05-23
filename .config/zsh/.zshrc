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
autoload -Uz compinit && compinit -C
unsetopt completealiases
zstyle ':completion:*' rehash true

## Nifty third party tools
#import gitstatus tool
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
HISTSIZE=100000
SAVEHIST=100000
setopt APPEND_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt EXTENDED_HISTORY
setopt SHARE_HISTORY
setopt histignorespace
setopt share_history 

# Colors for prompt
autoload -U colors && colors

# Default to vi mode bay-bee
bindkey -v
bindkey -v '^?' backward-delete-char
vim_ins_mode="■"
vim_cmd_mode="□"
vim_mode=$vim_ins_mode

function TRAPINT() {
  vim_mode=$vim_ins_mode
  return $(( 128 + $1 ))
} 

# Make home/end/del keys work properly
bindkey  "^[[7~"   beginning-of-line
bindkey  "^[[1~"   beginning-of-line
bindkey  "^[[8~"   end-of-line
bindkey  "^[[4~"   end-of-line
bindkey  "^[[3~"   delete-char
bindkey  "^[[5~"   up-line-or-history
bindkey  "^[[6~"   down-line-or-history

#Word Navigation
WORDCHARS=''
bindkey "^[[1;5C" forward-word 
bindkey "^[[1;5D" backward-word

# Autosuggestions and syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

#Setup thefuck
[[ ! -a $XDG_CACHE_HOME/thefuck ]] && mkdir -p $XDG_CACHE_HOME/thefuck && thefuck --alias > $XDG_CACHE_HOME/thefuck
source $XDG_CACHE_HOME/thefuck
fuck-command-line() {
    local FUCK="$(THEFUCK_REQUIRE_CONFIRMATION=0 thefuck $(fc -ln -1 | tail -n 1) 2> /dev/null)"
    [[ -z $FUCK ]] && echo -n -e "\a" && return
    BUFFER=$FUCK
    zle end-of-line
}
zle -N fuck-command-line
bindkey -M emacs '\e\e' fuck-command-line
bindkey -M vicmd '\e\e' fuck-command-line
bindkey -M viins '\e\e' fuck-command-line

# Exit shell w/ ^D even if there is something in the command line
exit_zsh() { exit }
zle -N exit_zsh
bindkey '^D' exit_zsh

# Setup fzf
source /usr/share/fzf/key-bindings.zsh

#Source ssh environment
source ~/.ssh/agent-environment > /dev/null

# Color support for ls, fd, etc
eval $(dircolors $XDG_CONFIG_HOME/dircolors)

# Style completion menu
zstyle ':completion:*' menu select
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' completer _extensions _complete _approximate
zstyle ':completion:*' group-name '' 
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:options' list-colors '=^(-- *)=35'
zstyle ':completion:*:descriptions' format '%F{8}■%f %F{red}━━━[%f%d%F{red}]%f'
zstyle ':completion:*:messages' format '%F{8}■%f %F{red}━━━[%f%d%F{red}]%f'
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'

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

#Collapse path to single chars if it gets too long
collapse_pwd() {
    echo $(pwd | sed -e "s,^$HOME,~,")
}

#Truncate the dir path
truncated_pwd() {
  n=$1 # n = number of directories to show in full (n = 3, /a/b/c/dee/ee/eff)
  path=`collapse_pwd`

  # split our path on /
  dirs=("${(s:/:)path}")
  dirs_length=$#dirs

  if [[ $dirs_length -ge $n ]]; then
    # we have more dirs than we want to show in full, so compact those down
    ((max=dirs_length - n))
    for (( i = 1; i <= $max; i++ )); do
      step="$dirs[$i]"
      if [[ -z $step ]]; then
        continue
      fi
      if [[ $step =~ "^\." ]]; then
        dirs[$i]=$step[0,2] #make .mydir => .m
      else
        dirs[$i]=$step[0,1] # make mydir => m
      fi
      
    done
  fi

  echo ${(j:/:)dirs}
}

#Vim mode helper function; notifies current state
zle-keymap-select() {
  vim_mode="${${KEYMAP/vicmd/${vim_cmd_mode}}/(main|viins)/${vim_ins_mode}}"
  custom_prompt
	zle reset-prompt
}
zle -N zle-keymap-select

zle-line-finish() {
  vim_mode=$vim_ins_mode
}
zle -N zle-line-finish

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
  cpos=$(cup)
  case "$cpos" in
    1|2)
		  PROMPT=""
      ;;
    *)
		  PROMPT=$'\n'
      ;;
  esac
	PROMPT+="%{$fg[red]%}┏━"

	#Are we root?
	[ "$(id -u)" -eq 0 ] && PROMPT+="[%{$fg[white]%}root%{$fg[red]%}]%{%G━%}"
	
	#Current directory
	PROMPT+="[%{$fg[white]%}%{$(truncated_pwd 3)%}%{$fg[red]%}]"
	
	#Git status
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
		PROMPT+=$'\n'"%{$fg[red]%}┗━━ %F{8}${vim_mode}%f %{$reset_color%}"
	else
		PROMPT+=$'\n'"%{$fg[red]%}┗━━ %{$reset_color%}${vim_mode} "
	fi
	
	setopt no_prompt_{bang,subst} prompt_percent  # enable/disable correct prompt expansions
}

gitstatus_stop 'MY' && gitstatus_start -s -1 -u -1 -c -1 -d -1 'MY'
autoload -Uz add-zsh-hook
add-zsh-hook preexec setup
add-zsh-hook precmd custom_prompt
export PROMPT2="%F{8} %{%G■%}%f%{$reset_color%} "

### General configs
# Pfetch configuration
export PF_INFO="ascii title os host kernel wm pkgs shell editor palette"

#Icons for lf
source ~/.config/lf/lficons

### Aliases
alias svim='sudoedit'
alias li="exa --icons"
alias l="exa -la"
alias ip="ip --color=auto"
alias diff='diff --color=auto'
alias clip="xsel -ib --logfile /dev/null"
alias cat="bat -p"
alias pfetch="curl -s https://raw.githubusercontent.com/dylanaraps/pfetch/master/pfetch | sh"
alias ls="exa"
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
alias dotlink="stow --ignore='.git' --ignore='screenshots' --ignore='wallpapers' --ignore='.gitignore' --ignore='pkglist.txt' --ignore='README.md' -R --target=/home/barbaross -d /home/barbaross/Public/thonkpad-dotfiles ."
alias sshpi="ssh -p 5522 barbaross@192.168.0.2"
alias trp="trash-put"
alias trr="trash-restore"
alias tre="trash-empty"
alias ovpn="sudo openvpn --config /etc/openvpn/client/barbarossOvpn.ovpn --askpass /etc/openvpn/barbarossOvpn.pass --daemon"
alias kovpn="sudo pkill -INT openvpn"
alias wgu="sudo wg-quick up barbarossvpn"
alias wgd="sudo wg-quick down barbarossvpn"
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....="cd ../../../.."
alias _="sudo"
alias cmus='tmux new-session -s Music "tmux source-file ~/.config/cmus/tmux_session"'
alias newsboat='newsboat -q'
alias bnps='java -jar ~/Public/font-stuff/bitsnpicas/main/java/BitsNPicas/BitsNPicas.jar'
alias spotdl="ts pipx run spotdl -o ~/Music"
alias usv="SVDIR=~/.local/service sv"
alias figlet="figlet -d ~/Public/figlet-fonts"
alias doom="crispy-doom -iwad ~/Public/Games/Doom/DOOM.WAD >/dev/null"
alias doom2="crispy-doom -iwad ~/Public/Games/Doom/DOOM2.WAD >/dev/null"

### Functions
# Colorized man pages
man() {
	env \
		LESS_TERMCAP_mb=$(printf "\e[1;31m") \
		LESS_TERMCAP_md=$(printf "\e[1;31m") \
		LESS_TERMCAP_me=$(printf "\e[0m") \
		LESS_TERMCAP_se=$(printf "\e[0m") \
		LESS_TERMCAP_so=$(printf "\e[1;40;35m") \
		LESS_TERMCAP_ue=$(printf "\e[0m") \
		LESS_TERMCAP_us=$(printf "\e[1;33m") \
		man "$@"
}

# auto cd on exiting lf with 'Q'
lf () {
    local tempfile="$(mktemp)"
    command lf -command "map Q \$echo \$PWD >$tempfile; lf -remote \"send \$id quit\"" "$@"
	  
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
		echo "zsh: cl: $dir: Directory not found"
	fi
}

dotgit() {
	gitdir="/home/barbaross/Public/thonkpad-dotfiles/"
	git -C $gitdir add .
	git -C $gitdir commit -m "$*"
	git -C $gitdir push
}

# one off calculator
calc() {
	echo "scale=3;$@" | bc -l
}

# Cht query
cht() {
	curl -s "cheat.sh/$(echo -n "$*" | jq -sRr @uri)"
}

# ncdu for btrfs
btdu() {
	sudo mkdir /btrfs-root
	sudo mount -o subvol=/ /dev/mapper/luks-3a14b623-8ada-431e-b8bc-94c93a87c249 /btrfs-root/
	sudo btdu /btrfs-root/
	sudo umount /btrfs-root/
	sudo rmdir /btrfs-root/
}

#Convert bdf to otb or ttf
bnps-conv() {
	if [[ $2 != *.bdf ]]; then
		echo "Input file must bs a bdf file!"
		exit
	fi

	case "$1" in
		otb)
			java -jar ~/Public/font-stuff/bitsnpicas/main/java/BitsNPicas/BitsNPicas.jar convertbitmap -f otb -o ${2:0:-4}.otb $2
			;;
		ttf)
			java -jar ~/Public/font-stuff/bitsnpicas/main/java/BitsNPicas/BitsNPicas.jar convertbitmap -f ttf -o ${2:0:-4}.ttf $2
			;;
		*)
			echo "Please specify otb or ttf first before passing the file path!"
			;;
		esac
}

#Embolden and convert
bnps-bld() {	
	if [[ $2 != *.bdf ]]; then
		echo "Input file must bs a bdf file!"
		exit
	fi

	case "$1" in
		otb)
			java -jar ~/Public/font-stuff/bitsnpicas/main/java/BitsNPicas/BitsNPicas.jar convertbitmap -b -f otb -o ${2:0:-4}.otb $2
			;;
		ttf)
			java -jar ~/Public/font-stuff/bitsnpicas/main/java/BitsNPicas/BitsNPicas.jar convertbitmap -b -f ttf -o ${2:0:-4}.ttf $2
			;;
		bdf)
			java -jar ~/Public/font-stuff/bitsnpicas/main/java/BitsNPicas/BitsNPicas.jar convertbitmap -b -f bdf -o ${2:0:-4}.bdf $2
			;;
		*)
			echo "Please specify otb, ttf, or bdf first before passing the file path!"
			;;
		esac
}

rld_btmp_fnts() {
	BTMP_FNT_DIR=~/.local/share/fonts/misc/

	echo "Recreating X11 font index files..."
	mkfontscale $BTMP_FNT_DIR
	mkfontdir $BTMP_FNT_DIR
	echo "Done!"

	echo ""

	echo "Refreshing X11 bitmap font database..."
	xset fp rehash
	echo "Done!"

	# Want to know its XLFD name?
	if [ -n "$*" ]; then
		echo""
		echo "XLFD Name(s:"
		xlsfonts | grep "$*" | sed 's/^/    /'
	fi
}

font_test() {
echo "

                0 1 2 3 4 5 6 7 8 9
A B C D E F G H I J K L M N O P Q R S T U V W X Y Z
a b c d e f g h i j k l m n o p q r s t u v w x y z
            ! @ # \$ % ^ & * ( ) _ + = -
                   , . / ; ' [ ]
                   < > ? : \" { }

"
}

command_not_found_handler() {
	txtred='\e[0;31m'
  txtwht='\e[0;37m'
  echo -e "M'lord, thy command ${txtred}$1${txtwht} does not exist!"
  
  suggestions=$(xlocate $1 2>/dev/null | grep ".*/bin/$1$")
  if [ -n "$suggestions" ]; then
    echo ""
    echo "Would one of these suffice, m'lord?:"
    echo $suggestions | sed 's/^/    /'
  fi
  return 127
}
