# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="/Users/szymonkin/.oh-my-zsh"

# ZSH_THEME="robbyrussell"
ZSH_THEME="powerlevel10k/powerlevel10k"

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

function pgres() {
  if [ $# -eq 0 ]; then
    echo "Provide one argument of type: start | stop"
    return
  fi

  pg_ctl -D '/usr/local/var/postgres@11' -l logfile $1
}

function copy_branch_name() {
  git rev-parse --abbrev-ref HEAD |  tr -d '\n' | pbcopy
}

alias personal_cfg="git config --global user.email 'szymon.kin@gmail.com' && git config --global user.name 'hoolek77'"
alias jjm_cfg="git config --global user.email 'szymon.kin@jjmdevelopment.pl' && git config --global user.name 'Szymon Kin'"

function detect_git_config() {
  JJM_KEYWORD="jjm"

  if [[ "$@" == *"$JJM_KEYWORD"* ]]
  then
    jjm_cfg
  else
    personal_cfg
  fi
}

# function cd () {
#   DEV_KEYWORD="dev"
#
#   if [[ "$@" == *"$DEV_KEYWORD"* ]]
#   then
#     builtin cd "$@" && detect_git_config "$@";
#   else
#     builtin cd "$@"
#   fi
# }

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
