default['shelby']['user']['name'] = 'gt'

default['shelby']['user_rvm']['username'] = 'gt'
default['shelby']['user_rvm']['default_ruby'] = 'ruby-1.9.3'
default['shelby']['user_rvm']['rubies'] = ['ruby-1.9.3']

default['shelby']['web']['domain'] = 'shelby.tv'
default['shelby']['web']['certificates']['dir'] = "#{node['nginx']['dir']}/certificates"
