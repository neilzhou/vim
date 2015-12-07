#!/bin/bash
ROOT_UID=0
VIMPLUGIN_PATH="/home/neilzhou/.vim"
VIMINSTALL_PATH="/usr/share/vim/vim74"

#  www.educity.cn/linux/1575485.html
if [ `whoami` != "root" ]
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
then
  echo "GIT installed"
else
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
if [ -f ./fencview.vim ]
then
 cp fencview.vim $VIMINSTALL_PATH/plugin/
fi

# install powerline fonts
git clone https://github.com/powerline/fonts.git
if [ -x ./fonts/install.sh ]
then
  ./fonts/install.sh
fi

# install YCM in Ubuntu x64
apt-get install -y build-essential cmake python-dev
cd $VIMPLUGIN_PATH/bundle/YouCompleteMe/
git submodule update --init --recursive
# http://www.centoscn.com/shell/2014/1030/4022.html check OS is 32/64 bit 
if [ $(getconf WORD_BIT) = '32' ] && [ $(getconf LONG_BIT) = '64' ]
then
  $VIMPLUGIN_PATH/bundle/YouCompleteMe/install.py --clang-completer
else
  $VIMPLUGIN_PATH/bundle/YouCompleteMe/install.py
fi

exit 1
