alias vim="nvim"
alias sz="source ~/.zshrc"
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"
alias media="cd /run/media/indiebreath"
alias pe="EDITOR=nvim pass edit"
alias reboot="umount ~/sambashare && reboot"

alias nvimconfig="vim ~/.config/nvim"
alias zshrc="vim ~/.zshrc"
alias hyprconfig="vim ~/.config/hypr/hyprland.conf"
alias waybarconfig="vim ~/.config/waybar"

alias fileserver="ssh indiebreath@192.168.50.164"
alias mainserver="ssh indiebreath@192.168.50.70"

alias gsa="git stage -A"
alias gcm="git commit -m"
alias gpo="git push origin"
alias gc="git checkout"
alias gcb="git checkout -b"
alias gpl="git pull"

alias yc="yay -Sc"
alias yu="yay -Syu"
alias yr="sudo pacman -Rs"
alias pac="sudo pacman -S"

alias npi="npm install"
alias npu="npm uninstall"
alias nprd="npm run dev"
alias nprs="npm run start"
alias npuu="npm update"

alias db="mariadb -u root -p"
alias apacheconf="sudo nvim /etc/httpd/conf/httpd.conf"
alias phpconf="sudo nvim /etc/php/php.ini"
alias mariadbconf="sudo nvim /etc/my.cnf.d"

alias clangdev="clang -std=c99 -Wall -Werror"
alias clangbuild="clang -std=99"

alias notes="vim ~/Documents/Notes"
alias schoolnotes="vim ~/Documents/School/Notes"

alias libreoffice="~/scripts/libreofficewriter.sh"

eval "$(zoxide init --cmd cd zsh)"
eval "$(thefuck --alias fk)"

export EDITOR=nvim
export VISUAL=nvim
