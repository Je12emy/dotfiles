# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
# Taken from: https://yazi-rs.github.io/docs/quick-start#shell-wrapper
# Open yazi and output it's working directory to a temp file
# then cd into said dir
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
# Aliases
alias v='nvim'
alias z='zellij'

# Enable Completition
# autoload -Uz compinit
# compinit
# zstyle ':completion:*' menu select # Press tab twice and navigate with arrow keys

# Plugins, I use zap: https://github.com/zap-zsh/zap/tree/master
plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/supercharge"
plug "zsh-users/zsh-syntax-highlighting"

eval "$(zoxide init --cmd cd zsh)"
# Initialize starship
eval "$(starship init zsh)"
