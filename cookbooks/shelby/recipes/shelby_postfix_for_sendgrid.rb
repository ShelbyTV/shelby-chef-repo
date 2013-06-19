#
# Cookbook Name:: shelby
# Recipe:: shelby_postfix_for_sendgrid
#
# Copyright 2013, Shelby.tv
#
# All rights reserved - Do Not Redistribute
#
# Install postfix and configure it to relay email through our sendgrid account

node.set['postfix']['mydomain']                = "shelby.tv"
node.set['postfix']['smtp_sasl_auth_enable']   = "yes"
node.set['postfix']['smtp_tls_cafile']         = "/etc/postfix/gd_bundle-g2.crt"
node.set['postfix']['smtp_sasl_user_name']     = "smtp_login@shelby.tv"
node.set['postfix']['smtp_sasl_passwd']        = "$h3lby"
node.set['postfix']['relayhost']               = "[smtp.sendgrid.net]:587"
node.set['postfix']['header_size_limit']       = "4096000"

#install prerequisites for sasl auth with postfix and install postfix
include_recipe "postfix::sasl_auth"

# copy over CA certificate for TLS verification
cookbook_file "/etc/postfix/gd_bundle-g2.crt" do
  owner 'root'
  group 'root'
  mode 0600
end