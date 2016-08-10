#!/bin/bash
ROOT_UID=0
VIMPLUGIN_PATH="/home/nzhou/.vim"
# you can use command 'sudo find / -name vim' to find the path
VIMINSTALL_PATH="/usr/local/Cellar/vim/7.4.2152/share/vim/vim74"

#  www.educity.cn/linux/1575485.html
if [ `whoami` != "root" ]
then
  echo "You are not root role, please use sudo command to execute this shell."
  exit 0
fi

# install ctags command
brew install ctags

# check PHP
# http://justcoding.iteye.com/blog/2010678 判断命令是否存在
if command -v php 2>/dev/null
then
  echo "PHP installed"
else
  brew install php5
fi

# check GIT
# http://justcoding.iteye.com/blog/2010678 判断命令是否存在
if command -v git 2>/dev/null
then
  echo "GIT installed"
else
  brew install git
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
brew install ack

# install ag
brew install the_silver_searcher

# install cscope
brew install cscope

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
brew install cmake
brew install node
cd $VIMPLUGIN_PATH/bundle/YouCompleteMe/
#git submodule update --init --recursive
# http://www.centoscn.com/shell/2014/1030/4022.html check OS is 32/64 bit 
if [ $(getconf WORD_BIT) = '32' ] && [ $(getconf LONG_BIT) = '64' ]
then
  $VIMPLUGIN_PATH/bundle/YouCompleteMe/install.py --clang-completer --tern-completer
else
  $VIMPLUGIN_PATH/bundle/YouCompleteMe/install.py
fi

exit 1
