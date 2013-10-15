#
# Cookbook Name:: shelby
# Recipe:: shelby_web_nginx
#
# Copyright 2012, Shelby.tv
#
# All rights reserved - Do Not Redistribute
#
# Install and congigure nginx to serve a web app with unicorn
# This should be as generic and configurable as possible
# Eventually we'll replace shelby_web_nginx.rb with this

node.set['nginx']['disable_robots_logging'] = false
node.set['nginx']['worker_processes'] = 1
node.set['nginx']['multi_accept'] = "on"
node.set['nginx']['tcp_nodelay'] = "off"

include_recipe "nginx::source"

nginx_app node['shelby']['nginx']['app_name'] do
  server_name node['ipaddress']
  listen ['80 default_server', 'localhost']
  # listen ['80 default_server', '443 ssl', 'localhost']
  locations [
    {
      :path => "/",
      :directives => [
        "proxy_set_header X-Forwarded-Proto $scheme;",
        "proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;",
        "proxy_set_header X-Real-IP $remote_addr;",
        "proxy_set_header Host $host;",
        "proxy_redirect off;",
        "proxy_http_version 1.1;",
        "proxy_set_header Connection '';",
        "proxy_pass http://#{node['shelby']['nginx']['upstream']};"
      ]
    }
  ].concat node['shelby']['web']['nginx']['custom_locations']
  upstreams [
    {
      :name => "#{node['shelby']['nginx']['upstream']}",
      :servers => ["unix:/tmp/#{node['shelby']['nginx']['upstream']}.socket fail_timeout=0"]
    }
  ]
  keepalive_timeout 70
end