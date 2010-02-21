#!/bin/sh
#
########################################################################
# MacPorts Python 3.1 installer
#
#  Maintainer: id774 <idnanashi@gmail.com>
#
#  v1.0 2/21,2010
#       Stable.
########################################################################

make_symlink() {
  while [ $# -gt 0 ]
  do
    sudo ln -fs /opt/local/bin/$13.1 /usr/local/bin/$1
    shift
  done
}

make_custom_symlink() {
    sudo ln -fs /opt/local/bin/python3.1-config /usr/local/bin/python-config
    sudo ln -fs /opt/local/bin/2to3-3.1 /usr/local/bin/2to3
    sudo ln -fs /opt/local/bin/easy_install-3.1 /usr/local/bin/easy_install
}

setup_symlink() {
    make_symlink python pythonw pydoc idle
    make_custom_symlink
}

remove_symlink() {
  while [ $# -gt 0 ]
  do
    sudo rm /usr/local/bin/$1
    shift
  done
}

erase_symlink() {
    remove_symlink python pythonw pydoc idle python-config 2to3
    sudo ln -fs /opt/local/bin/python2.5 /usr/local/bin/python
    sudo ln -fs /opt/local/bin/easy_install-2.5 /usr/local/bin/easy_install
}

install() {
    sudo port -d uninstall python31
    setup_symlink
}

activate() {
    sudo port activate python31
    setup_symlink
}

uninstall() {
    sudo port -d uninstall python31
    erase_symlink
}

deactivate() {
    sudo port deactivate python31
    erase_symlink
}

parse_option() {
    case "$1" in
      install)
        install
        ;;
      activate)
        activate
        ;;
      deactivate)
        deactivate
        ;;
      uninstall)
        uninstall
        ;;
    esac
}

test -n "$1" || exit 1
test -n "$1" && parse_option "$1"
python -V

