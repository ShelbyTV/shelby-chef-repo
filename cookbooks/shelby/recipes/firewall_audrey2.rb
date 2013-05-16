#
# Cookbook Name:: shelby
# Recipe:: firewall_web
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

# open standard http port to tcp traffic from shelby api box only
firewall_rule "http" do
  port 80
  source '108.166.56.26'
  protocol :tcp
  action :allow
end

# by default, reject all incoming traffic
firewall_rule "all" do
  action :reject
end