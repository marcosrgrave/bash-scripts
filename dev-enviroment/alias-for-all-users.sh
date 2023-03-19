#!bin/bash

tee -a /etc/profile.d/00-aliases.sh <<EOF
# ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Space Vim
alias svim='vim -u ~/.SpaceVim/vimrc'

# Show current branch on terminal
git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
export PS1="\[\]\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$(git_branch)\$ "
EOF
