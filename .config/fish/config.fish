if status is-interactive
    # Commands to run in interactive sessions can go here
    source /opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc
end

alias vi "nvim"
alias dot "/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
pyenv init - | source
