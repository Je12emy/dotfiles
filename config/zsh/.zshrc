# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

# Variables
export EDITOR='nvim'
export TERMINAL='kitty'
export BROWSER='firefox'

# Aliases
alias v='nvim'
alias za='zathura --fork'

# Enable Completition
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select # Press tab twice and navigate with arrow keys

# Program Installation
# fnm, a version manager for node: https://github.com/Schniz/fnm
export PATH="/home/jeremy/.local/share/fnm:$PATH"
eval "`fnm env`"

# .Net
export PATH="$PATH:/home/jeremy/.dotnet/tools"
alias nuget="mono /usr/local/bin/nuget.exe"

# Go
export PATH=$PATH:/usr/local/go/bin

# Plugins, I use zap: https://github.com/zap-zsh/zap/tree/master
plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/supercharge"
plug "zsh-users/zsh-syntax-highlighting"

# Initialize starship
eval "$(starship init zsh)"
