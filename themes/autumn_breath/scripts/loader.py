#!/usr/bin/env python3
import os
import sys
import shutil

themePath = sys.argv[1]
themeDotfiles = themePath + '/dotfiles/'
awesomeDotfiles = os.path.expanduser("~/.config/awesome/dotfiles/")

### Install BASE16 color scheme ###

#BASE16 Shell
if not os.path.exists(os.path.expanduser("~/.config/base16-shell/")):
    os.system("git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell")

#FlatColor 2.0
if not os.path.exists(os.path.expanduser("~/.local/share/themes/FlatColor/")):
    os.system("git clone https://github.com/jasperro/FlatColor ~/.local/share/themes/FlatColor")


### Load Dotfiles ###
shutil.copyfile(themeDotfiles+'zshrc', awesomeDotfiles+'zshrc')
shutil.copyfile(themeDotfiles+'vimrc', awesomeDotfiles+'vimrc')


#os.system(base16ShellCommand)
