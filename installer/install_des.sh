#!/bin/sh
#
########################################################################
# Install Des
#
#  Maintainer: id774 <idnanashi@gmail.com>
#
#  v1.0 5/21,2009
#       Derived from install_crypt.sh.
########################################################################

set_des_permission() {
    case $OSTYPE in
      *darwin*)
        sudo chown -R root:wheel /usr/local/src/crypt/des
        ;;
      *)
        sudo chown -R root:root /usr/local/src/crypt/des
        ;;
    esac
}

install_des() {
    mkdir install_des
    cd install_des
    wget http://id774.net/archive/kmdes-ubuntu.tar.gz
    md5.sh kmdes-ubuntu.tar.gz
    tar xzvf kmdes-ubuntu.tar.gz
    rm kmdes-ubuntu.tar.gz
    cd des
    test -d /usr/local/src/crypt/des && sudo rm -rf /usr/local/src/crypt/des
    sudo mkdir -p /usr/local/src/crypt/des
    sudo cp * /usr/local/src/crypt/des
    make
    sudo make install
    cd ..
    rm -rf des
    cd ..
    rm -rf install_des
    set_des_permission
}

which dmsetup > /dev/null || sudo aptitude -y install dmsetup
which des > /dev/null || install_des