#
# Cookbook Name:: shelby
# Recipe:: shelby_email
#
# Copyright 2012, Shelby.tv
#
# All rights reserved - Do Not Redistribute
#
# Set up a server for hosting a copy of shelby_gt that sends mass emails
# by relaying them through Postifx then Sendgrid

include_recipe "shelby::shelby_user_rvm"
include_recipe "memcached"
include_recipe "shelby::shelby_postfix_for_sendgrid"
include_recipe "shelby::firewall_ssh_only"