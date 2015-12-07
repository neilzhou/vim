#!/bin/bash
ROOT_UID = 0
VIM_PATH = "/home/neilzhou/.vim"

if ["$UID" -ne "$ROOT_UID"]
then
  echo "You are not root role, please use sudo command to execute this shell."
  exit 0
fi

# install ctags command
apt-get install -y exuberant-ctags

# check PHP
# http://justcoding.iteye.com/blog/2010678 ÅÐ¶ÏÃüÁîÊÇ·ñ´æÔÚ
if command -v php 2>/dev/null
then
  echo "PHP installed"
else
  apt-get install -y php5
fi

# check GIT
# http://justcoding.iteye.com/blog/2010678 ÅÐ¶ÏÃüÁîÊÇ·ñ´æÔÚ
if command -v git 2>/dev/null
else
  echo "GIT installed"
then
  apt-get install -y php5
fi

# install tagbar for php
curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
composer require nikic/php-parser
curl -Ss http://vim-php.com/phpctags/install/phpctags.phar > phpctags
if [ -e ./phpctags ]
then
  chmod +x ./phpctags
  mv ./phpctags /usr/local/bin/phpctags
fi

# install ack
apt-get install -y ack-grep
dpkg-divert --local --divert /usr/bin/ack --rename --add /usr/bin/ack-grep

# install ag
apt-get install -y silversearcher-ag

# install cscope
apt-get install -y cscope

# install fencview
curl -sS http://www.vim.org/scripts/download_script.php?src_id=21657 > fencview.vim
if [ -f ./fencview.vim 
 cp fencview.vim /usr/share/vim/vim74/plugin/
then 

# install YCM in Ubuntu x64
apt-get install -y build-essential cmake python-dev
# http://www.centoscn.com/shell/2014/1030/4022.html check OS is 32/64 bit 
if [ $(getconf WORD_BIT) = '32' ] && [ $(getconf LONG_BIT) = '64' ]
then
  $VIM_PATH/bundle/YouCompleteMe/install.py --clang-completer
else
  $VIM_PATH/bundle/YouCompleteMe/install.py
fi

# install powerline fonts
git clone https://github.com/powerline/fonts.git
if [ -x ./fonts/install.sh ]
then
  ./fonts/install.sh
fi