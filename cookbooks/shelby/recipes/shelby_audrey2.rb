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
include_recipe "shelby::firewall_audrey2"

node.set[:redis][:save_to_disk] = {
  900 => 1,
  300 => 10,
  60  => 10000
}
node.set[:redis][:datadir] = "/home/#{node['shelby']['user']['name']}"
include_recipe "redis"