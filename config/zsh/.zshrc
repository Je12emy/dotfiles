# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
# Aliases
alias v='nvim'
alias za='zathura --fork'
alias zl='zellij'
alias netcoredbg='/usr/local/netcoredbg'

# Enable Completition
autoload -Uz compinit
compinit
# zstyle ':completion:*' menu select # Press tab twice and navigate with arrow keys

# Plugins, I use zap: https://github.com/zap-zsh/zap/tree/master
plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/supercharge"
plug "zsh-users/zsh-syntax-highlighting"

(cat ~/.cache/wal/sequences &)
eval "$(zoxide init --cmd cd zsh)"
# Initialize starship
eval "$(starship init zsh)"
