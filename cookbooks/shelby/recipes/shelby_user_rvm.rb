#
# Cookbook Name:: shelby
# Recipe:: shelby_user_rvm
#
# Copyright 2012, Shelby.tv
#
# All rights reserved - Do Not Redistribute
#
# Recipe to create the user under which shelby apps will be installed and run,
# then do a user install of rvm for that user

include_recipe "shelby::user"
node['shelby']['user_rvm']['username'] = node['shelby']['user']['name']
include_recipe "shelby::user_rvm"