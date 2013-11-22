#
# Cookbook Name:: shelby
# Recipe:: firewall_redis
#
# Copyright 2012, Shelby.tv
#
# All rights reserved - Do Not Redistribute
#
# Recipe to setup iptables for redis access

# open standard redis port, enable firewall
node['shelby']['firewall']['redis_allowed_sources'].each do |allowed_source|
  firewall_rule "redis" do
    port 6379
    protocol :tcp
    action :allow
    source allowed_source
    notifies :enable, "firewall[ufw]"
  end
end