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
# don't cache the bookmarklet code so it will be easier to test changes in staging
node['shelby']['web']['nginx']['extension-cache']['expires'] = false

include_recipe "shelby::shelby_web"
include_recipe "redis"