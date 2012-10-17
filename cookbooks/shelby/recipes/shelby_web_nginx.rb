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

certificate_file = "#{node['shelby']['web']['certificates']['dir']}/#{node['shelby']['web']['domain']}.crt"
key_file = "#{node['shelby']['web']['certificates']['dir']}/#{node['shelby']['web']['domain']}.key"

if node['shelby']['web']['certificates']['install']
  # install the ssl certificates
  directory node['shelby']['web']['certificates']['dir'] do
    owner "root"
    group "root"
    mode "0755"
    action :create
  end

  cookbook_file certificate_file do
    owner 'root'
    group 'root'
    mode 0600
  end

  cookbook_file key_file do
    owner 'root'
    group 'root'
    mode 0600
  end
end

nginx_app "shelby-gt-web" do
  server_name node['ipaddress']
  listen ['80 default_server', '443 ssl', 'localhost']
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
      :path => "= /assets/shelbify.js",
      :directives => [
        "root /home/gt/web/current/public;",
        node['shelby']['web']['nginx']['extension-cache']['expires'] ? "expires #{node['shelby']['web']['nginx']['extension-cache']['expires']};" : nil,
        "gzip_static on;",
        node['shelby']['web']['nginx']['extension-cache']['expires'] ? "add_header Cache-Control public;" : nil
      ].compact
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
        "root /home/gt/web/current/public;",
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
  custom_directives [
    "ssl_certificate #{certificate_file};",
    "ssl_certificate_key #{key_file};",
    "ssl_session_timeout 10m;",
    "ssl_protocols  SSLv2 SSLv3 TLSv1;",
    "ssl_ciphers  HIGH:!aNULL:!MD5;",
    "ssl_prefer_server_ciphers   on;"
  ]
  keepalive_timeout 70
end