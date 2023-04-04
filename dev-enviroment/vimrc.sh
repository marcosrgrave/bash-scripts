#! bin/bash

echo '
" -------------------- CUSTOM --------------------

" Relative number lines
set relativenumber

" 4 spaces tab size
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
' | sudo tee -a /etc/vim/vimrc > /dev/null

echo "Vim configs added to '/etc/vim/vimrc'."
