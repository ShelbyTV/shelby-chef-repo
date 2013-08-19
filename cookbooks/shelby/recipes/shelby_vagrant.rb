#
# Cookbook Name:: shelby
# Recipe:: shelby_vagrant
#
# Copyright 2012, Shelby.tv
#
# All rights reserved - Do Not Redistribute
#
# Provision the Shelby vagrant box for developing both shelby-gt and shelby-gt-web

include_recipe "apt"

node['shelby']['user']['name'] = 'vagrant'
node['shelby']['user_rvm']['username'] = node['shelby']['user']['name']
include_recipe "shelby::user_rvm"
include_recipe "shelby::shelby_memcached"
include_recipe "redis"
include_recipe "java"
require_recipe "mongodb::10gen_repo"
require_recipe "mongodb"

# install additional packages required by the shelby rails app
package "libcurl4-gnutls-dev" do
  action :install
end

# need QT for capybara-webkit
package "libqt4-dev" do
  action :install
end

package "libqtwebkit-dev" do
  action :install
end

# need xvfb for headless gem which allows us to run webkit headless
package "xvfb" do
  action :install
end

# need jackd1 for qt or capybara-webkit or something (complains without it)
package "jackd1" do
  action :install
end

# need imagemagick for capybara-webkit to take screenshots within headless
# browser for debugging
package "imagemagick" do
  action :install
end

# we need NFS for better-performing Vagrant shared folders
package "nfs-common" do
  action :install
end

# delete the persistent interfaces file to avoid host-only networking
# problems when re-packaging the box
file "/etc/udev/rules.d/70-persistent-net.rules" do
  action :delete
  ignore_failure true
end