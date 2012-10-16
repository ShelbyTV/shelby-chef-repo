#
# Cookbook Name:: shelby
# Recipe:: shelby_web_staging
#
# Copyright 2012, Shelby.tv
#
# All rights reserved - Do Not Redistribute
#
# Set up a staging server for the Shelby web app

node['shelby']['web']['domain'] = 'staging.shelby.tv'

include_recipe "shelby::shelby_web"

# install the self-signed ssl certificate for staging.shelby.tv
directory node['shelby']['web']['certificates']['dir'] do
  owner "root"
  group "root"
  mode "0755"
  action :create
end

cookbook_file node['shelby']['web']['certificates']['certificate_file'] do
  owner 'root'
  group 'root'
  mode 0600
end

cookbook_file node['shelby']['web']['certificates']['key_file'] do
  owner 'root'
  group 'root'
  mode 0600
end