# nnsh:

# custom prompt
setopt PROMPT_SUBST
autoload -U promptinit
promptinit
prompt grb

# initialize completion
autoload -U compinit
compinit -D

# ensure user-installed binaries take precedence
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH

# Useful aliases
alias l='ls -1Gt'
alias ll='ls -gohGt'
alias la='ls -gohGa'
alias nodetree='tree -I "node_modules" .'
alias ngp='npm ls -g --depth=0'
alias vi='vim'

# History
export HISTSIZE=100000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE

# Plugins
# source ~/.zsh_plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh_plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
# source ~/.zsh_plugins/zsh-git-prompt/zshrc.sh

# PROMPT='%C$(git_super_status) $ '
# RPROMPT='%{$fg[grey]%}%n%{$reset_color%}@%{$fg[cyan]%}%m%{$reset_color%}'

# bind P and N for EMACS mode
bindkey -e
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

export EDITOR=vi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

n() {
  cd ~/Dropbox/notes
  local files
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
  cd -
}

