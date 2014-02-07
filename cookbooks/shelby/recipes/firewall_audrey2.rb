#
# Cookbook Name:: shelby
# Recipe:: firewall_audrey2
#
# Copyright 2012, Shelby.tv
#
# All rights reserved - Do Not Redistribute
#
# Recipe to setup iptables for SSH and HTTP on the audrey2/BotRolls server

# enable platform default firewall
firewall "ufw" do
  action :enable
end

# open standard ssh port, enable firewall
firewall_rule "ssh" do
  port 22
  action :allow
end

# open standard http port to tcp traffic from allowed sources only
node['shelby']['firewall']['audrey2_allowed_sources'].each do |allowed_source|
  firewall_rule "audrey2_http" do
    port 80
    source allowed_source
    protocol :tcp
    action :allow
  end
end

# by default, reject all incoming traffic
firewall_rule "all" do
  action :reject
end