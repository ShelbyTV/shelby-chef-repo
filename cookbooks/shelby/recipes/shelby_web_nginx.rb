#
# Cookbook Name:: shelby
# Recipe:: shelby_web_nginx
#
# Copyright 2012, Shelby.tv
#
# All rights reserved - Do Not Redistribute
#
# Install and congigure nginx to serve Shelby web app

node['nginx']['worker_processes'] = 1

include_recipe "nginx::source"