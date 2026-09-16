# ---------------------------------------------
# ZSH OPTIONS
# ---------------------------------------------


setopt extended_glob		# extend glob syntax
setopt interactivecomments	# enable comments within the interactive shell
setopt autocd				# if command is not a normal command and is a directory cd into it


# ---------------------------------------------
# ENVIRONMENT VARIABLES
# ---------------------------------------------


# home config directory
export XDG_CONFIG_HOME="$HOME/.config"

# editor
#export VISUAL=nvim
#export EDITOR=nvim

# browser
export BROWSER="firefox"

# less
export LESS="-R"	# render ANSI color codes

# directories
export REPOS="$HOME/repos"
export SCRIPTS="$HOME/.local/bin"
export ZSH="$HOME/.zsh"


# ---------------------------------------------
# PATH
# ---------------------------------------------


path=(
	$path			    # keep existing PATH entries
	$HOME/bin
	$HOME/.local/bin
	$SCRIPTS
)

typeset -U path			# remove and ignore duplicates
path=($^path(N-/))		# remove non-existing

export PATH


# ---------------------------------------------
# HISTORY
# ---------------------------------------------


HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000

setopt HIST_IGNORE_SPACE	# don't save when prefixed with space
setopt HIST_IGNORE_DUPS		# don't save duplicate lines
setopt SHARE_HISTORY		# share hist between sessions
setopt HIST_VERIFY          # when '!' history expansion,
                                # show command before executing


# ---------------------------------------------
# COMPLETION
# ---------------------------------------------


autoload -Uz compinit
compinit -u

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'     # case insensitive
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}" # colored completions


# ---------------------------------------------
# PROMPT
# ---------------------------------------------


# pure prompt - clone if needed

if [[ ! -d "$HOME/.zsh/pure" ]]; then
    git clone --depth=1 https://github.com/sindresorhus/pure.git "$ZSH/pure"
fi

fpath+=($HOME/.zsh/pure)				# add path to the cloned repo to $fpath
autoload -Uz promptinit; promptinit		# initialize prompt system

prompt pure								# choose pure as the prompt
#prompt adam1


# ---------------------------------------------
# KEY BINDINGS
# ---------------------------------------------


# set vi-style key bindings
#set -o vi

# Ctrl+f to run tmux-sessionizer
#bindkey -s '^f' 'tmux-sessionizer\n'


# ---------------------------------------------
# ALIASES
# ---------------------------------------------


# common use
alias c='clear -x'
alias e='exit'
alias open='xdg-open'
alias hist='history'
alias please='eval "sudo $(fc -ln -1)"'
#alias tmx='tmux-sessionizer'

# editor
alias v='vim'
alias v.='vim .'
alias nv='nvim'
alias nv.='nvim .'
alias code='flatpak run com.vscodium.codium'

# common typos
alias gti='git'

# change some commands' default behaviors
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff='diff --color=always'
alias wget='wget --continue'		# continue getting partially downloaded files

# dotfiles
alias dot='tmux-sessionizer $DOTFILES'
alias zshrc='$EDITOR ~/.zshrc && source ~/.zshrc'
#alias tmuxrc='$EDITOR $HOME/.tmux.conf'
#alias nvimrc='tmux-sessionizer $XDG_CONFIG_HOME/nvim'
#alias kittyrc='tmux-sessionizer $XDG_CONFIG_HOME/kitty'

# cd / navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../.. && echo "(no way u rly think thats the best way u couldve done that)"'
alias repos='cd $REPOS'
alias scripts='tmux-sessionizer $SCRIPTS'
alias project='cd $PROJECT'
alias pro='tmux-sessionizer $PROJECT'
alias notes='tmux-sessionizer $NOTES'

# ls / eza
#alias ls='ls --group-directories-first --indicator-style=slash'
alias ls='ls --color --group-directories-first --indicator-style=slash'
alias la='ls -A'                            # all files
alias ll='ls -Al -h'                        # long list
alias l.="ls -A | grep -e '^\.'"            # show only dotfiles
alias ltime='ls -lAh -t'                    # sort by time, newest first
alias lsize='ls -lAh -S'                    # sort by size, smallest first

if type -p eza &>/dev/null; then
    # if eza is installed
    alias ez='command eza --group-directories-first'
    alias eza='ez -A'								# all files
    alias ezl='ez -AlgH --git'						# long list

    alias tree='ez --tree'							# tree view
    alias ltree='ezl --tree --git --git-ignore'      # tree view long list 
fi

# find files recursively and sort by last modified; ignore hidden files
alias lmod='find . -type f -not -path "*/\.*" -exec ls -lrt {} +'

# timestamp
alias ts='date +%y%m%d'             # YYMMDD
alias tslong='date +%y%m%d_%H%M%S'  # YYMMDD_hhmmss
alias tsepoch='date +%s'            # seconds since Unix epoch

# recently installed packages
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"

# c compiler / gcc
alias ccw='cc -Wall -Wextra -Werror'

# /><>/ 42 /><>/
alias mini='~/mini-moulinette/mini-moul.sh'
alias examshell='git clone https://github.com/Seraph919/Grademe-edu && cd Grademe-edu && make && make'
alias francinette='$HOME/francinette/tester.sh'
alias paco='francinette'


# ---------------------------------------------
# TOOLS
# ---------------------------------------------


# fzf - clone repo if needed
if [[ ! -d "$ZSH/fzf" ]]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git $ZSH/fzf
	$ZSH/fzf/install --bin		# install to $ZSH/fzf/bin
fi
path+=($ZSH/fzf/bin)
if command -v fzf &>/dev/null; then
	source <(fzf --zsh)         # source fzf configuration for zsh
fi

## zsh autosuggestions - clone repo if needed
#if [[ ! -d "$ZSH/zsh-autosuggestions" ]]; then
#    git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git "$ZSH/zsh-autosuggestions"
#fi
#source "$ZSH/zsh-autosuggestions/zsh-autosuggestions.zsh"

## zsh syntax highlighting - clone repo if needed
#if [[ ! -d "$ZSH/zsh-syntax-highlighting" ]]; then
#    git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH/zsh-syntax-highlighting"
#fi
#source "$ZSH/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"


# ---------------------------------------------
# END
# ---------------------------------------------

# source local configuration
[ -f $HOME/.zshrc.local ] && source $HOME/.zshrc.local
export PATH="$HOME/.local/bin:$PATH"
