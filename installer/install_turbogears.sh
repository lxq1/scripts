#!/bin/sh
#
########################################################################
# Install TurboGears
#
#  Maintainer: id774 <idnanashi@gmail.com>
#
#  v0.1 2/19,2009
#       First version.
########################################################################

TARGET_PATH=`python -c "from distutils.sysconfig import get_python_lib; print get_python_lib()"`

wget http://www.turbogears.org/download/tgsetup-betaversion.py
sudo python tgsetup.py
sudo cp tgsetup.py $TARGET_PATH/tgsetup.py
rm tgsetup.py
