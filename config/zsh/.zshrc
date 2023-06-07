# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

# Variables
export EDITOR='nvim'
export TERMINAL='kitty'
export BROWSER='firefox'

# Aliases
alias v='nvim'

# Enable Completition
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select # Press tab twice and navigate with arrow keys

# Plugins, I use zap: https://github.com/zap-zsh/zap/tree/master
plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/supercharge"
plug "zsh-users/zsh-syntax-highlighting"

# Initialize starship
eval "$(starship init zsh)"
