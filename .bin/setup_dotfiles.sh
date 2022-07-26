info () {
  printf "\r  [ \033[00;34m..\033[0m ] $1\n"
}

user () {
  printf "\r  [ \033[0;33m??\033[0m ] $1\n"
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
  echo ''
  exit
}

install_brew () {
  # let's install and setup homebrew.
  if ! hash brew 2>/dev/null; then
    info "installing homebrew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/nicknikolov/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
    source ~/.zprofile
    success "ok done"
  else
    success "homebrew is already installed."
  fi

  info "now installing brew packages"
  brew bundle --file ~/.config/brewfile/Brewfile || true 
  success "ok done"
}

install_brew

info "switching shell to fish"
# for intel switch `/opt/homebrew` to `/usr/local`
echo /opt/homebrew/bin/fish | sudo tee -a /etc/shells
chsh -s /opt/homebrew/bin/fish
