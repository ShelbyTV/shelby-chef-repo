#
# Cookbook Name:: shelby
# Recipe:: shelby_web
#
# Copyright 2012, Shelby.tv
#
# All rights reserved - Do Not Redistribute
#
# Set up a server for the Shelby web app

node['shelby']['web']['certificates']['dir'] = "#{node['nginx']['dir']}/certificates"

include_recipe "shelby::shelby_user_rvm"
# we need Java for rails asset pipeline js minification with YUI
include_recipe "java"
include_recipe "shelby::shelby_web_nginx"
include_recipe "shelby::firewall_web_server"