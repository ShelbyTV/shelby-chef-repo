#
# Cookbook Name:: shelby_redis
# Recipe:: default
#
# Copyright 2012, Shelby.tv
#
# All rights reserved - Do Not Redistribute
#
# Install a redis server

node[:redis][:version] = "2.6.4"
include_recipe "redis"