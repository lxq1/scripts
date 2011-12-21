#!/bin/sh
#
########################################################################
# Install Ruby and Rails
#
#  Maintainer: id774 <idnanashi@gmail.com>
#
#  v0.1 7/11,2011
#       First.
########################################################################

test -n "$SCRIPTS" || export SCRIPTS=$HOME/scripts
test -n "$PRIVATE" || export PRIVATE=$HOME/private/scripts

# Ruby
#$SCRIPTS/installer/install_ruby.sh 187-svn /opt/ruby/1.8.7
#$SCRIPTS/installer/install_ruby.sh 191-svn /opt/ruby/1.9.1
#$SCRIPTS/installer/install_ruby.sh 192-svn /opt/ruby/1.9.2
$SCRIPTS/installer/install_ruby.sh 193-svn /opt/ruby/1.9.3
$SCRIPTS/config/update-alternatives-ruby.sh

# RubyGems
#$SCRIPTS/installer/install_rubygems.sh 162 /opt/ruby/1.9.3
$SCRIPTS/installer/install_gems.sh /opt/ruby/1.9.3
#$SCRIPTS/installer/install_rails.sh 300 /opt/ruby/1.9.3
/opt/ruby/1.9.3/bin/vim-ruby-install.rb

# Passenger
$SCRIPTS/installer/install_passenger.sh /opt/ruby/1.9.3
$SCRIPTS/config/update-alternatives-ruby.sh

