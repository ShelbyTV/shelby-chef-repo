#
# Cookbook Name:: shelby
# Recipe:: shelby_web
#
# Copyright 2012, Shelby.tv
#
# All rights reserved - Do Not Redistribute
#
# Set up a server for the Shelby web app

include_recipe "shelby::shelby_user_rvm"
# we need Java for rails asset pipeline js minification with YUI
include_recipe "java"

node['shelby']['web']['certificates']['certificate_file'] = "#{node['shelby']['web']['certificates']['dir']}/#{node['shelby']['web']['domain']}.crt"
node['shelby']['web']['certificates']['key_file'] = "#{node['shelby']['web']['certificates']['dir']}/#{node['shelby']['web']['domain']}.key"

include_recipe "shelby::shelby_web_nginx"