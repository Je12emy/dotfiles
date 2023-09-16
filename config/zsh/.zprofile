# fnm, a version manager for node: https://github.com/Schniz/fnm
export PATH="/home/jeremy/.local/share/fnm:$PATH"
eval "`fnm env`"

# Node package manager
export PNPM_HOME="/home/jeremy/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# .Net
export PATH="$PATH:/home/jeremy/.dotnet/tools"
alias nuget="mono /usr/local/bin/nuget.exe"

# Go
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:/home/jeremy/go/bin
