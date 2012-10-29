#
# Cookbook Name:: shelby
# Recipe:: firewall_web
#
# Copyright 2012, Shelby.tv
#
# All rights reserved - Do Not Redistribute
#
# Recipe to setup iptables for SSH, HTTP, and HTTPS on a web server

# open standard ssh port, enable firewall
firewall_rule "ssh" do
  port 22
  action :allow
  notifies :enable, "firewall[ufw]"
end

# open standard http port to tcp traffic only; insert as first rule
firewall_rule "http" do
  port 80
  protocol :tcp
  action :allow
end

# open standard https port to tcp traffic only; insert as first rule
firewall_rule "https" do
  port 443
  protocol :tcp
  action :allow
end

firewall "ufw" do
  action :nothing
end