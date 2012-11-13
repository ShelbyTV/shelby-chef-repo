#
# Cookbook Name:: shelby_redis
# Recipe:: default
#
# Copyright 2012, Shelby.tv
#
# All rights reserved - Do Not Redistribute
#
# Install a redis server

# !!we'll want to use version 2.6.4 when there's a cookbook that supports it!!
# node.set[:redis][:version]   = "2.6.4"
# node.set[:redis][:dir]       = "redis-#{node.redis.version}"
# node.set[:redis][:source]    = "http://redis.googlecode.com/files/#{node.redis.dir}.tar.gz"

include_recipe "redis"