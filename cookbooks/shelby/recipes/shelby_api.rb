#
# Cookbook Name:: shelby
# Recipe:: shelby_api
#
# Copyright 2012, Shelby.tv
#
# All rights reserved - Do Not Redistribute
#
# Set up a server for the Shelby api

# node['shelby']['nginx']['listen'] = ['80 default_server', '443 ssl', 'localhost']

node.set['shelby']['nginx']['app_name'] = 'shelby-gt-api'
node.set['shelby']['nginx']['upstream'] = 'shelby-gt-api'

include_recipe "shelby::shelby_user_rvm"
include_recipe "apt"
# we need Java for rails asset pipeline js minification with YUI
include_recipe "java"
include_recipe "shelby::memcached"
include_recipe "shelby::shelby_mongodb_hosts"
include_recipe "shelby::shelby_nginx"
include_recipe "shelby::firewall_web_server"

package "scons" do
  action :install
end