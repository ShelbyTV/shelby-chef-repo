#
# Cookbook Name:: shelby
# Recipe:: memcached
#
# Copyright 2012, Shelby.tv
#
# All rights reserved - Do Not Redistribute
#
# Installs the prerequisites that a Shelby app needs
# for the memcached gem

package "libsasl2-dev" do
	action :install
end

package "gettext" do
	action :install
end

include_recipe "memcached"