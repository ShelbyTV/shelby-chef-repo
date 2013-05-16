#
# Cookbook Name:: shelby
# Recipe:: user_rvm
#
# Copyright 2012, Shelby.tv
#
# All rights reserved - Do Not Redistribute
#
# Recipe to do a user install of rvm

# install rvm for the nos user
node.set['rvm']['user_installs'] = [
  {
    'user'          => node['shelby']['user_rvm']['username'],
    'default_ruby'  => node['shelby']['user_rvm']['default_ruby'],
    'rubies'        => node['shelby']['user_rvm']['rubies'],
    'version'       => node['shelby']['user_rvm']['version'],
    'branch'        => node['shelby']['user_rvm']['branch']
  }
]
include_recipe "rvm::user"