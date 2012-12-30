#!/usr/bin/env bash

echo "Running 'apt-get update'"
apt-get update

# grub-pc causes problems with unattended upgrade
#echo "Running 'apt-get upgrade'"
#apt-get upgrade -y

echo "Running 'apt-get install ...'"
apt-get install -y build-essential git zlib1g-dev libssl-dev

if [ ! -d "/tmp/ruby-build" ]; then
    echo "Installing ruby-build"
    git clone git://github.com/sstephenson/ruby-build.git "/tmp/ruby-build"
    pushd  /tmp/ruby-build
        ./install.sh
    popd
fi

if [ -z "$RUBY_VERSION" ]; then
    RUBY_VERSION=`ruby-build --definitions | grep "^1.9.3-p[0-9]\+" | sort -r | head -1`
fi

if [ ! -f /usr/local/bin/ruby ]; then
    echo "Installing Ruby $RUBY_VERSION"
    ruby-build "$RUBY_VERSION" /usr/local
fi

if [ ! -f /usr/local/etc/gemrc ]; then
    echo "Disabling Ruby docs generation"
    echo "install: --no-rdoc --no-ri
update:  --no-rdoc --no-ri" > /usr/local/etc/gemrc
fi

gem list --local | grep -q bundler
if [ $? -ne 0 ]; then
    echo "Installing Bundler"
    gem install bundler
fi

gem list --local | grep -q chef
if [ $? -ne 0 ]; then
    echo "Installing Chef"
    gem install chef
fi

gem list --local | grep -q librarian
if [ $? -ne 0 ]; then
    echo "Installing Librarian"
    gem install librarian
fi
