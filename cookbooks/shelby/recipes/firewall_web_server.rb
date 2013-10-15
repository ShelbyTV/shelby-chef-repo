#
# Cookbook Name:: shelby
# Recipe:: firewall_web_server
#
# Copyright 2012, Shelby.tv
#
# All rights reserved - Do Not Redistribute
#
# Recipe to setup iptables for SSH, HTTP, and HTTPS on a web server

# enable platform default firewall
firewall "ufw" do
  action :enable
end

# open standard ssh port, enable firewall
firewall_rule "ssh" do
  port 22
  action :allow
end

# open standard http port to tcp traffic only
firewall_rule "http" do
  port 80
  protocol :tcp
  action :allow
end

# open standard https port to tcp traffic only
firewall_rule "https" do
  port 443
  protocol :tcp
  action :allow
end