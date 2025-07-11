# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
unsetopt beep
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/indiebreath/.zshrc'

autoload -Uz compinit
compinit

autoload -Uz promptinit
promptinit
prompt elite2 magenta
# End of lines added by compinstall

zstyle ':completion:*' rehash true

alias vim="nvim"
alias sz="source ~/.zshrc"
alias media="cd /run/media/indiebreath"
alias zip="zip -r"
alias ll="ls -la"
alias df="duf"

alias nvimconfig="vim ~/.config/nvim"
alias zshrc="vim ~/.zshrc"
alias hyprconfig="vim ~/.config/hypr/hyprland.conf"
alias waybarconfig="vim ~/.config/waybar"

alias gsa="git stage -A"
alias gcm="git commit -m"
alias gpo="git push origin"
alias gc="git checkout"
alias gcb="git checkout -b"
alias gpl="git pull"

alias lzg="lazygit"

alias yc="yay -Sc"
alias yu="yay -Syu"
alias yr="sudo pacman -Rs"
alias pac="sudo pacman -S"
alias ys="yay -S"

alias db="mariadb -u root -p"
alias apacheconf="sudo nvim /etc/httpd/conf/httpd.conf"
alias phpconf="sudo nvim /etc/php/php.ini"
alias mariadbconf="sudo nvim /etc/my.cnf.d"

alias clangdev="clang -std=c99 -Wall -Werror"
alias clangbuild="clang -std=99"
alias pybuild="pyinstaller -F"

alias notes="vim ~/Notes"
alias schoolnotes="vim ~/School/School_Notes"
alias appdata="cd /usr/share/applications"

alias remotelogin="ssh indiebreath@100.68.21.58"

alias umountvms="umount /run/media/indiebreath/VMs"

eval "$(zoxide init --cmd cd zsh)"
eval "$(starship init zsh)"

export EDITOR=nvim
export VISUAL=nvim
export ELECTRON_OZONE_PLATFORM_HINT=wayland
