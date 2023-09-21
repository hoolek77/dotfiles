# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"

export ZSH="/Users/szymonkin/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

alias vim="nvim"
alias jjm="cd /Users/szymonkin/dev/jjm/vinted-frontend/"
alias devscard="personal_cfg && cd /Users/szymonkin/dev/coders-crew/devscard/"
alias webwolf="personal_cfg && cd /Users/szymonkin/dev/webwolf/cam-recorder-frontend"
alias webwolf_backend_start="personal_cfg && cd /Users/szymonkin/dev/webwolf/cam-recorder-backend && ./vendor/bin/sail up"

function copy_branch_name() {
  git rev-parse --abbrev-ref HEAD |  tr -d '\n' | pbcopy
}

function ls () {
  if [ -n "$1" ]
  then
    colorls "$@"
  else
    colorls --tree=1
  fi
}

export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# pnpm
export PNPM_HOME="/Users/szymonkin/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

alias python=/usr/bin/python3

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
