#
# Cookbook Name:: shelby
# Recipe:: user
#
# Copyright 2012, Shelby.tv
#
# All rights reserved - Do Not Redistribute
#
# Recipe to create the user under which shelby apps will be installed and run

# we need ruby-shadow in order to create a user using a hashed password
package "libshadow-ruby1.8" do
	action :install
end

user "shelby_user" do
  username node['shelby']['user']['name']
  home "/home/#{node['shelby']['user']['name']}"
  shell "/bin/bash"
  password "$6$pu6KsMcI07I7$EqHrdyiY/TNrimT1Vhw/tDU5ElAQpUgWJ5GCXl9tz9xFPgil3jGnCVHuTgfDUnSU7O0ozeIhilGsLoaRpjwhm/"
  supports :manage_home => true
end

# add the user to the sudo group
group "sudo" do
  action :modify
  append true
  members [node['shelby']['user']['name']]
end