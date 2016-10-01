# dotfiles

Originally, this was a fork of [Zach Holman's dotfiles](https://github.com/holman/dotfiles) but it kind of evolved into my own thing. It's not super forkable unless you are me since it's super customized and not indented to be flexible. But still, if someone would want to have this, `script/bootstrap` install everything needed. This is meant to be used on OSX and Ubuntu and some of the bootstrapping scripts won't work on non-Debian distros.

### setting up a new ubuntu machine
1. check which shell you are by default by typing `echo $0`
2. if not in bash, type `bash`
3. get git, in order to clone this repo easily
```
sudo apt-get update
sudo apt-get install git
```
4. setup your ssh keys so you can clone from github using ssh (kind of optional)
5. now run `git clone git@github.com:nicknikolov/dotfiles.git` somewhere (usually, I have a work or workspace folder in every machine I touch)
6. now running the bootstrap script in the script folder should set everything up (installing zsh, neovim, brew if on os x, node and all dotfiles)



