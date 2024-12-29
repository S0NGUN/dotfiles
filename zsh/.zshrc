export M2_HOME=$HOME/workspace/apache-maven-3.9.5/

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

### for gopls LSP
export PATH=$PATH:$HOME/go/bin

### Set default editor to nvim
export EDITOR=nvim

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
#
# put forgit AFTER git TO AVOID OVERWRITING ALIASES
plugins=(
  git
  forgit
  zsh-autosuggestions
  zsh-syntax-highlighting
  vi-mode
)

source $ZSH/oh-my-zsh.sh

autoload -Uz compinit
compinit -i

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
SERUMPRESETS=/Library/Audio/Presets/Xfer\ Records/Serum\ Presets
SAMPLES=~/Music/Ableton/Sample\ Library
alias ws="cd ~/workspace && ls"
alias plugins="cd ~/.oh-my-zsh/custom/plugins"
alias lc="cd ~/workspace/LeetCode/"
alias dl="cd ~/Downloads && lss"
# alias cd="z" # CAUSES MAJOR WEIRD PROBLEMS!!!!
alias vim="nvim"

### shorthand for editing configs
alias zshrc="nvim ~/.zshrc"
alias tmuxc="nvim ~/.tmux.conf" 
alias kittyc="nvim ~/.config/kitty/kitty.conf"




[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH="/opt/homebrew/opt/openjdk@11/bin:$PATH"
export PATH="$PATH:~/Downloads/ltex-ls-plus-18.3.0/bin/"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/dalesong/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/dalesong/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/dalesong/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/dalesong/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# zoxide setup
eval "$(zoxide init zsh)"

####################
# CUSTOM FUNCTIONS #
####################

# MOVE TO SAMPLES
# Script to move $1 (New Sample Folder) to Ableton's Sample Library
movetosamples() {
    if [ -z "$SAMPLES" ]; then
        echo "SAMPLES variable is not set. Please set the SAMPLES environment variable to your Ableton's Sample Library folder set in the DAW"
        return 1
    fi

    if [ ! -d "$1" ]; then
        echo "The specified folder does not exist: $1"
        return 1
    fi

    mv "$1" "$SAMPLES" && echo "Successfully moved '$1' to '$SAMPLES'" || echo "Failed to move '$1' to '$SAMPLES'"
}

# Yazi y shell wrapper https://yazi-rs.github.io/docs/quick-start/#multi-tab
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# CUSTOM LS
function my_ls() {
	ls -lht | awk '{printf "%-10s %-15s %-20s %-50s\n", $5, $6" "$7, $8, $9}'; 
}
alias lss=my_ls

# BINDKEY Control + Space to autosuggest-accept
bindkey '^ ' autosuggest-accept


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# Recommended to add as the last line https://ohmyposh.dev/docs/installation/prompt
# eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/catppuccin_custom.yaml)"
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/negligible_custom.yaml)"
# eval "$(oh-my-posh init zsh --config $(brew --prefix oh-my-posh)/themes/catppuccin_mocha.omp.json)"
# eval "$(oh-my-posh init zsh --config $(brew --prefix oh-my-posh)/themes/1_shell.omp.json)"
# eval "$(oh-my-posh init zsh --config $(brew --prefix oh-my-posh)/themes/negligible.omp.json)"
# eval "$(oh-my-posh init zsh --config $(brew --prefix oh-my-posh)/themes/catppuccin.omp.json)"
# eval "$(oh-my-posh init zsh --config $(brew --prefix oh-my-posh)/themes/tokyo.omp.json)"
# eval "$(oh-my-posh init zsh --config $(brew --prefix oh-my-posh)/themes/emodipt-extend.omp.json)"
# eval "$(oh-my-posh init zsh --config $(brew --prefix oh-my-posh)/themes/onehalf.minimal.omp.json)"


# See: https://github.com/starship/starship/issues/3418
#if [[ "${widgets[zle-keymap-select]#user:}" == "starship_zle-keymap-select" || \
#       "${widgets[zle-keymap-select]#user:}" == "starship_zle-keymap-select-wrapped" ]]; then
#     zle -N zle-keymap-select "";
# fi

# eval "$(starship init zsh)"



