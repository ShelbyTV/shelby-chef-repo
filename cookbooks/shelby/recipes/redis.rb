#
# Cookbook Name:: shelby
# Recipe:: redis
#
# Copyright 2012, Shelby.tv
#
# All rights reserved - Do Not Redistribute
#
# Uses redisio cookbook to install redis with the dump
# file location configured to a standard location for all Shelby machines

node.set['redisio']['default_settings']['datadir'] = "/home/#{node['shelby']['user']['name']}/redis-dump"
include_recipe "redisio::install"
include_recipe "redisio::enable"