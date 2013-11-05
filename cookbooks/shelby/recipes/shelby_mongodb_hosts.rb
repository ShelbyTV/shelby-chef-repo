#
# Cookbook Name:: shelby
# Recipe:: shelby_mongodb_hosts
#
# Copyright 2012, Shelby.tv
#
# All rights reserved - Do Not Redistribute
#
# Setup /etc/hosts entries that allow shelby Mongomapper models
# to find the mongodb servers

hostsfile_entry '10.183.73.244' do
  hostname  'gt-api-a'
  action    :create
end


hostsfile_entry '10.176.99.101' do
  hostname  'gt-api-b'
  action    :create
end


hostsfile_entry '10.176.69.208' do
  hostname  'gt-db-conversation-s0-a'
  action    :create
end


hostsfile_entry '10.176.69.210' do
  hostname  'gt-db-conversation-s0-b'
  action    :create
end


hostsfile_entry '10.176.74.214' do
  hostname  'gt-db-user-action-s0-a'
  action    :create
end


hostsfile_entry '10.176.74.228' do
  hostname  'gt-db-user-action-s0-b'
  action    :create
end


hostsfile_entry '10.176.69.184' do
  hostname  'gt-db-video-s0-a'
  action    :create
end


hostsfile_entry '10.176.69.187' do
  hostname  'gt-db-video-s0-b'
  action    :create
end


hostsfile_entry '10.176.69.215' do
  hostname  'gt-db-roll-frame-s0-a'
  action    :create
end


hostsfile_entry '10.181.57.64' do
  hostname  'gt-db-roll-frame-s0-b'
  action    :create
end


hostsfile_entry '10.181.57.64' do
  hostname  'gt-db-roll-frame-s0-c'
  action    :create
end


hostsfile_entry '10.183.74.78' do
  hostname  'gt-db-dashboard-s0-a'
  action    :create
end


hostsfile_entry '10.176.64.171' do
  hostname  'gt-db-dashboard-s0-b'
  action    :create
end


hostsfile_entry '10.183.66.100' do
  hostname  'gt-db-deepcache-s0-a'
  action    :create
end


hostsfile_entry '10.183.66.108' do
  hostname  'gt-db-deepcache-s0-b'
  action    :create
end


hostsfile_entry '10.181.135.130' do
  hostname  'nos-db-s0-a'
  action    :create
end


hostsfile_entry '10.181.131.101' do
  hostname  'nos-db-s0-b'
  action    :create
end


hostsfile_entry '10.183.192.15' do
  hostname  'nos-db-s0-d'
  action    :create
end


hostsfile_entry '10.208.2.75' do
  hostname  'nos-db-s0-e'
  action    :create
end


hostsfile_entry '10.176.67.200' do
  hostname  'gt-db-prioritized-dashboard-s0-a'
  action    :create
end