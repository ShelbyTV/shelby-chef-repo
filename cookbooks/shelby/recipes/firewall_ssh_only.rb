#
# Cookbook Name:: shelby
# Recipe:: firewall_ssh_only
#
# Copyright 2012, Shelby.tv
#
# All rights reserved - Do Not Redistribute
#
# Recipe to setup iptables to allow SSH only

# enable platform default firewall
firewall "ufw" do
  action :enable
end

# open standard ssh port, enable firewall
firewall_rule "ssh" do
  port 22
  action :allow
end

# by default, reject all incoming traffic
firewall_rule "all" do
  action :reject
end