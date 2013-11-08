#
# Cookbook Name:: shelby
# Recipe:: shelby_nginx_status
#
# Copyright 2012, Shelby.tv
#
# All rights reserved - Do Not Redistribute
#
# Configure and enable a route on nginx to provide the stub_status

stub_status_app_name = "#{node['shelby']['nginx']['app_name']}-status"
nginx_app stub_status_app_name do
  server_name "localhost"
  listen ["127.0.0.1:#{node['shelby']['nginx']['stub_status']['port']}"]
  locations [{
    :path => "/",
    :directives => [
      "stub_status on;",
      "allow 127.0.0.1;",
      "deny all;"
    ]
  }]
  access_log "off"
end