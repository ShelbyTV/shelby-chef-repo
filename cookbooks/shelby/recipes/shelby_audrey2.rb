#
# Cookbook Name:: shelby
# Recipe:: shelby_audrey2
#
# Copyright 2012, Shelby.tv
#
# All rights reserved - Do Not Redistribute
#
# Set up a server for the audrey2 API and feed processing aka BotRolls

node.set['shelby']['nginx']['app_name'] = 'audrey2'
node.set['shelby']['nginx']['upstream'] = 'audrey2'

include_recipe "shelby::shelby_user_rvm"
include_recipe "shelby::shelby_nginx"
include_recipe "redis"
include_recipe "shelby::firewall_audrey2"