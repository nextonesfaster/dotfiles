### PATH SETUP
export PATH="/opt/homebrew/opt/python@3.11/libexec/bin:$PATH"
export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"
export PATH="/Library/TeX/texbin:$PATH"
export PATH="/usr/local/go/bin:$PATH"
export PATH="$PATH:$HOME/.local/bin:$HOME/.local/scripts"

# PKG config path for openssl
export PKG_CONFIG_PATH="-L/opt/homebrew/opt/openssl@3/lib/pkgconfig"

### ENV FLAGS
export CURL_SSL_BACKEND="secure-transport"
export CXXFLAGS="-std=c++11"

### UI/UX
ZSH_THEME_TERM_TITLE_IDLE="%~"
export CLICOLOR=1
DISABLE_AUTO_TITLE="true"

# Tab title = current directory
precmd() {
    echo -ne "\e]1;${PWD##*/}\a"
}

HISTCONTROL=ignorespace

### OH-MY-ZSH SETUP
export ZSH="$HOME/.oh-my-zsh"

plugins=(
    git
    zsh-syntax-highlighting
    zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

### CUSTOM CONFIG
source "${HOME}/.local/config/.zsh_aliases"
source "${HOME}/.local/config/.zsh_funcs"

### TOOLS INITIALIZATION
source /Users/arius/.config/broot/launcher/bash/br
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

### COMPLETION
fpath+=~/.zfunc
fpath+=/opt/homebrew/share/zsh/site-functions

autoload -Uz compinit && compinit

### FW TOOL CONFIG
if [[ -x "$(command -v fw)" ]]; then
  if [[ -x "$(command -v sk)" ]]; then
    eval $(fw print-zsh-setup -s 2>/dev/null);
  else
    eval $(fw print-zsh-setup 2>/dev/null);
  fi;
fi;

### CONDA INITIALIZATION
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/arius/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/arius/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/arius/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/arius/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
