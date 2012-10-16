#
# Cookbook Name:: shelby
# Recipe:: shelby_web_nginx
#
# Copyright 2012, Shelby.tv
#
# All rights reserved - Do Not Redistribute
#
# Install and congigure nginx to serve Shelby web app

node['nginx']['disable_robots_logging'] = false
node['nginx']['worker_processes'] = 1
node['nginx']['multi_accept'] = "on"
node['nginx']['tcp_nodelay'] = "off"

include_recipe "nginx::source"

nginx_app "shelby-gt-web" do
  server_name node['ipaddress']
  listen ['80 default_server', 'localhost']
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
        "proxy_pass http://shelby;"
      ]
    },
    {
      :path => "~ ^/(assets|fonts|images|javascripts|stylesheets|system)/",
      :directives => [
        "root /home/gt/web/current/public;",
        "gzip_static on;",
        "expires max;",
        "add_header Cache-Control public;"
      ]
    },
    {
      :path => "~ ^/favicon\.(ico|png)",
      :directives => [
        "gzip_static on;",
        "expires max;",
        "add_header Cache-Control public;"
      ]
    }
  ]
  upstreams [
    {
      :name => "shelby",
      :servers => ["unix:/tmp/shelby-web.socket fail_timeout=0"]
    }
  ]
  keepalive_timeout 70
end