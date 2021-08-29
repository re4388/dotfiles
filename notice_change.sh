#!/bin/bash

File=tmp
local_dotfiles_path=~/projects/dotfiles

cd ${local_dotfiles_path} 1>/dev/null
git fetch
git diff ...origin/main > $File
# cat $File
if grep -q @@ "$File"; then
  echo "==========================================================="
  echo 'Dotfiles have changes! Do you want to update from dotfiles?'
  echo "==========================================================="
fi

rm ${File}
