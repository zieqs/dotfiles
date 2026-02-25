# ==============================================================================
# UNIVERSAL ZSH CONFIG (Omarchy | MacBook M2 | Ubuntu Homelab)
# ==============================================================================

# --- 1. OS DETECTION & PATHS ---
if [[ "$OSTYPE" == "darwin"* ]]; then
    # MacBook Air M2 Specifics
    eval "$(/opt/homebrew/bin/brew shellenv)"
    alias ls='ls -G'
else
    # Linux (Arch/Ubuntu) Specifics
    alias ls='ls --color=auto'
    export SHELL=/usr/bin/zsh
fi

# --- 2. ENVIRONMENT VARIABLES ---
export TERM=xterm-256color
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

# --- 3. HISTORY SETTINGS ---
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt APPEND_HISTORY
setopt SHARE_HISTORY

# --- 4. PLUGINS & TOOLS ---
autoload -Uz compinit && compinit
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Zoxide (Smart cd)
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init zsh)"
fi

# --- Zsh Syntax Highlighting ---
# 1. First, define the styles array so Zsh doesn't crash
typeset -A ZSH_HIGHLIGHT_STYLES

# 2. Multi-OS Plugin Loader logic
PATHS=(
    "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
    "/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
    "/opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
)
for p in $PATHS; do [ -f "$p" ] && source "$p"; done

# 3. Apply customizations ONLY if the plugin was actually loaded
if (( ${+functions[_zsh_highlight]} )); then
    ZSH_HIGHLIGHT_STYLES[command]='fg=#859900,bold'
    ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#DC322F,bold'
fi

# --- 5. UNIVERSAL ALIASES ---
alias grep='grep --color=auto'
alias zconf='nano ~/.zshrc'
alias homelab='ssh zieqs@192.168.0.226'
alias hl='ssh zieqs@192.168.0.226' # Ubuntu style shortcut

# --- 6. MACHINE-SPECIFIC ALIASES ---

# ARCH (Omarchy)
if command -v pacman &> /dev/null; then
    alias update='sudo pacman -Syu'
fi

# MAC (Homebrew)
if command -v brew &> /dev/null; then
    alias bzap='brew uninstall --zap --cask'
    alias bpurge='brew uninstall --rmtree'
    alias bclean='brew autoremove && brew cleanup'
    alias gconf='nano ~/.config/ghostty/config'
fi

# UBUNTU / HOMELAB
if [[ "$(hostname)" == *"homelab"* ]] || [ -f /etc/debian_version ]; then
    alias checkup='~/Scripts/checkup.sh'
    alias maintain='~/Scripts/maintain.sh'
    alias nextcloud_logs='docker logs nextcloud' # Direct since we're already on the server
fi

# --- 7. STARTUP & THEME ---
if command -v fastfetch &> /dev/null; then
    clear
    fastfetch
fi

if command -v starship &> /dev/null; then
    eval "$(starship init zsh)"
fi
