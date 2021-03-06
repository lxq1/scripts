#!/bin/sh
#
########################################################################
# Install Ruby
#  $1 = ruby version (ex. 200-481)
#  $2 = ruby path (ex. /opt/bin)
#  $3 = no sudo
#
#  Maintainer: id774 <idnanashi@gmail.com>
#
#  v2.1 1/14,2019
#       Remove obsolete versions.
#  v2.0 3/11,2015
#       Fix bugs.
#       Specify nosudo option.
#  v1.0 6/23,2008
#       Stable.
########################################################################

make_ext_module() {
  while [ $# -gt 0 ]
  do
    cd ext/$1
    $SUDO $RUBY extconf.rb
    $SUDO make
    $SUDO make install
    cd ../..
    shift
  done
}

make_and_install() {
    $SUDO autoconf
    test -n "$1" || $SUDO ./configure --with-opt-dir=/usr/local
    test -n "$1" && $SUDO ./configure --prefix $1 --with-opt-dir=/usr/local
    $SUDO make
    $SUDO make install
}

install_trunk() {
    test -d /usr/local/src/ruby || $SUDO mkdir -p /usr/local/src/ruby
    cd /usr/local/src/ruby
    if [ -d /usr/local/src/ruby/trunk ]; then
        cd trunk
        $SUDO svn up
    else
        $SUDO svn co http://svn.ruby-lang.org/repos/ruby/trunk trunk
        cd trunk
    fi
    make_and_install $2
    make_ext_module zlib readline openssl
    $SUDO chown -R $OWNER /usr/local/src/ruby/trunk
    test -x $SCRIPTS/installer/install_emacs_ruby.sh && \
    $SCRIPTS/installer/install_emacs_ruby.sh /usr/local/src/ruby/trunk/misc
}

install_branch() {
    test -d /usr/local/src/ruby/branches || $SUDO mkdir -p /usr/local/src/ruby/branches
    cd /usr/local/src/ruby/branches
    if [ -d /usr/local/src/ruby/branches/$1 ]; then
        cd $1
        $SUDO svn up
    else
        $SUDO svn co http://svn.ruby-lang.org/repos/ruby/branches/$1/ $1
        cd $1
    fi
    make_and_install $2
    make_ext_module zlib readline openssl
    $SUDO chown -R $OWNER /usr/local/src/ruby/branches/$1
    test -x $SCRIPTS/installer/install_emacs_ruby.sh && \
    $SCRIPTS/installer/install_emacs_ruby.sh /usr/local/src/ruby/branches/$1/misc
}

install_stable3() {
    mkdir install_ruby
    cd install_ruby
    curl -L https://cache.ruby-lang.org/pub/ruby/$2/ruby-$1.tar.gz -O
    tar xzvf ruby-$1.tar.gz
    cd ruby-$1
    make_and_install $3
    make_ext_module zlib readline openssl
    cd ..
    test -n "$SUDO" && save_sources $*
    cd ..
    $SUDO rm -rf install_ruby
    test -x $SCRIPTS/installer/install_emacs_ruby.sh && \
    $SCRIPTS/installer/install_emacs_ruby.sh /usr/local/src/ruby/ruby-$1/misc
}

install_stable2() {
    mkdir install_ruby
    cd install_ruby
    curl -L http://cache.ruby-lang.org/pub/ruby/$2/ruby-$1.tar.bz2 -O
    tar xjvf ruby-$1.tar.bz2
    cd ruby-$1
    make_and_install $3
    make_ext_module zlib readline openssl
    cd ..
    test -n "$SUDO" && save_sources $*
    cd ..
    $SUDO rm -rf install_ruby
    test -x $SCRIPTS/installer/install_emacs_ruby.sh && \
    $SCRIPTS/installer/install_emacs_ruby.sh /usr/local/src/ruby/ruby-$1/misc
}

install_stable() {
    mkdir install_ruby
    cd install_ruby
    wget ftp://ftp.ruby-lang.org/pub/ruby/$2/ruby-$1.zip
    unzip ruby-$1.zip
    cd ruby-$1
    make_and_install $3
    make_ext_module zlib readline openssl
    cd ..
    test -n "$SUDO" && save_sources $*
    cd ..
    $SUDO rm -rf install_ruby
    test -x $SCRIPTS/installer/install_emacs_ruby.sh && \
    $SCRIPTS/installer/install_emacs_ruby.sh /usr/local/src/ruby/ruby-$1/misc
}

save_sources() {
    test -d /usr/local/src/ruby || $SUDO mkdir -p /usr/local/src/ruby
    $SUDO cp $OPTIONS ruby-$1 /usr/local/src/ruby
    $SUDO chown -R $OWNER /usr/local/src/ruby/ruby-$1
}

setup_environment() {
    test -n "$2" || export RUBY=ruby
    test -n "$2" || test -x /usr/local/bin/ruby && export RUBY=/usr/local/bin/ruby
    test -n "$2" || test -x /opt/ruby/current/bin/ruby && export RUBY=/opt/ruby/current/bin/ruby
    test -n "$2" && export RUBY=$2/bin/ruby
    test -n "$3" || SUDO=sudo
    test -n "$3" && SUDO=
    test "$3" = "sudo" && SUDO=sudo
    case $OSTYPE in
      *darwin*)
        OPTIONS=-pR
        OWNER=root:wheel
        ;;
      *)
        OPTIONS=-a
        OWNER=root:root
        ;;
    esac
}

install_ruby() {
    setup_environment $*
    case "$1" in
      265)
        install_stable3 2.6.5 2.6 $2
        ;;
      257)
        install_stable3 2.5.7 2.5 $2
        ;;
      249)
        install_stable3 2.4.9 2.4 $2
        ;;
      238)
        install_stable3 2.3.8 2.3 $2
        ;;
      26-svn)
        install_branch ruby_2_6 $2
        ;;
      25-svn)
        install_branch ruby_2_5 $2
        ;;
      24-svn)
        install_branch ruby_2_4 $2
        ;;
      23-svn)
        install_branch ruby_2_3 $2
        ;;
      trunk)
        install_trunk $2
        ;;
      *)
        ;;
    esac

    ruby -v
}

ping -c 1 id774.net > /dev/null 2>&1 || exit 1
install_ruby $*
