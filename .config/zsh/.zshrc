######################
#
# ░▀▀█░█▀▀░█░█░█▀▄░█▀▀
# ░▄▀░░▀▀█░█▀█░█▀▄░█░░
# ░▀▀▀░▀▀▀░▀░▀░▀░▀░▀▀▀
#
######################

# Auto start X
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  export XAUTHORITY="/tmp/Xauthority"
	exec startx ${HOME}/.config/x11/xinitrc -- ${HOME}/.config/x11/xserverrc -background none -keeptty &>/dev/null
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.config/zsh/histfile
HISTSIZE=1000
SAVEHIST=1000
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/barbarossa/.config/zsh/.zshrc'

autoload -Uz compinit && compinit
# End of lines added by compinstall

# Move antigen directory
export ADOTDIR="${HOME}/.config/zsh/antigen"

# Tell antigen to look for my zshrc elsewhere
typeset -a ANTIGEN_CHECK_FILES=($HOME/.config/zsh/.zshrc)

# Plugins
source ~/.config/zsh/antigen.zsh

antigen use oh-my-zsh

antigen bundle history-substring-search
antigen bundle z
antigen bundle ripgrep
antigen bundle fzf
antigen bundle fd
antigen bundle colored-man-pages
antigen bundle command-not-found
antigen bundle git
antigen bundle tmux
antigen bundle taskwarrior 
antigen bundle pass
antigen bundle ufw
antigen bundle systemd
#antigen bundle thefuck

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions

antigen theme romkatv/powerlevel10k

antigen apply

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.config/zsh/p10k.zsh ]] || source ~/.config/zsh/p10k.zsh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

# Aliases
alias weather="curl 'wttr.in/?T'"
alias svim="sudoedit"
alias cht='f(){ curl -s "cheat.sh/$(echo -n "$*"|jq -sRr @uri)";};f'
alias li="exa --icons"
#alias clip="xclip -sel clip"
alias clip="xsel -ib"
#alias logout="kill -9 -1"
alias startvpn="autoumbvpn.sh"
alias stopvpn="nmcli c d UMB"
alias sshthanos="ssh cullen.ross@thanos.igs.umaryland.edu"
alias c="bc -l"
alias yayinst="paru -Slq | fzf -m --preview 'paru -Si {1}' | xargs -ro paru -S"
alias cat="bat"
alias pfetch="curl -s https://raw.githubusercontent.com/dylanaraps/pfetch/master/pfetch | sh"
#alias fet="curl -s https://raw.githubusercontent.com/6gk/fet.sh/master/fet.sh | sh"
#alias doom="~/.emacs.d/bin/doom"
#alias vim="TERM=xterm-24bit emacsclient -nw -s term"
#alias emacs="TERM=xterm-24bit emacsclient -nw -s term"
#alias vim="nvim"
#alias navi="navi --fzf-overrides '--reverse  --color fg:7,bg:-1,hl:6,fg+:6,bg+:-1,hl+:6,info:2,prompt:1,spinner:5,pointer:5,marker:3,header:8'"
alias yay="paru"
alias sshpi="ssh pi@192.168.0.18"
alias piunmount="ssh pi@192.168.0.18 sudo /mnt/fd1/unmount.sh"
alias pacclean="sudo pacman -Rns $(pacman -Qtdq)"
alias ls="exa"
alias ncdu="ncdu --color dark"
#alias backupssh="rsync -a --delete --quiet -e ssh / pi@192.168.0.18:/media/RaspberryPi/Genome"
alias sfeedc="SFEED_URL_FILE=~/.config/sfeed/read_sfeed SFEED_PIPER='w3m -T text/html -cols $(tput cols) -dump | urlscan -d' SFEED_PLUMBER_INTERACTIVE=1 SFEED_PLUMBER='feed_plumb.sh' sfeed_curses ~/.config/sfeed/feeds/*"
alias scan="scanimage --device 'hpaio:/net/OfficeJet_3830_series?ip=192.168.0.13' --progress --format=png --output-file"

# colorscheme for fzf
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'  --color fg:7,bg:-1,hl:6,fg+:6,bg+:-1,hl+:6 --color info:2,prompt:1,spinner:5,pointer:5,marker:3,header:8'

#for bat theme
export BAT_THEME="base16"

# Apparently you can't have just one server, every instance has to be a server
# if I want to be able to hot reload colorscheme for all running instances of vim
#vim() {
#  current=$(/usr/bin/vim --serverlist | tail -n1)
#
#  if [ -z "$current" ]; then
#	  /usr/bin/vim --servername 1 "$@"
#  else
#	  new=$(($current + 1))
#	  /usr/bin/vim --servername "$new" "$@"
#  fi
#}

#lf settings
#exit to w/e dir I traveled to
lf () {
  tmp="$(mktemp)" 
  /usr/bin/lf --last-dir-path="$tmp" "$@"
  #${HOME}/.local/bin/lfimg --last-dir-path="$tmp" "$@"
  if [ -f "$tmp" ]; then
    dir="$(cat "$tmp")"
    rm -f "$tmp"
    if [ -d "$dir" ]; then
      if [ "$dir" != "$(pwd)" ]; then
        cd "$dir"
      fi
    fi
  fi
}

# Icons
source ~/.config/lf/lficons

# Completion settings
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==35=35}:${(s.:.)LS_COLORS}")';
zstyle ':completion:*:descriptions' format $'\e[01;33m %d\e[0m'
zstyle ':completion:*:messages' format $'\e[01;31m %d\e[0m'

# Pkgfile to help figure out unknown commands
#source /usr/share/doc/pkgfile/command-not-found.zsh

# Pfetch configuration
export PF_INFO="ascii title os kernel wm pkgs shell term editor palette"
# for pfetch; term doesn't show properly in tmux
export TERM_PROGRAM="st"

#fet.sh configuration
export info="n user os sh wm kern pkgs term col n"
export accent=3
export separator=" ⏹ "
#export colourblocks="■"
