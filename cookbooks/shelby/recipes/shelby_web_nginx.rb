#
# Cookbook Name:: shelby
# Recipe:: shelby_web_nginx
#
# Copyright 2012, Shelby.tv
#
# All rights reserved - Do Not Redistribute
#
# Install and congigure nginx to serve Shelby web app

node['nginx']['init_style'] = 'init'

node['nginx']['worker_processes'] = 1
node['nginx']['pid'] = '/var/run/nginx.pid'

node['nginx_conf']['confs'] = [{
  '50.56.123.73' => {
    'socket' => "/tmp/shelby-web.socket"
  }
}]

include_recipe "nginx"
include_recipe "nginx_conf"