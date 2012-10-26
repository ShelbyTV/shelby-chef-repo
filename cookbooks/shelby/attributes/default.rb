default['shelby']['user']['name'] = 'gt'

default['shelby']['user_rvm']['username'] = 'gt'
default['shelby']['user_rvm']['default_ruby'] = 'ruby-1.9.3'
default['shelby']['user_rvm']['rubies'] = ['ruby-1.9.3']

default['shelby']['web']['domain'] = 'shelby.tv'
default['shelby']['web']['certificates']['dir'] = "#{node['nginx']['dir']}/certificates"
default['shelby']['web']['certificates']['file_ext'] = "crt"
default['shelby']['web']['certificates']['install'] = true

#--- only caching extension/bookmarklet code for 2 days b/c we don't have cache busting
default['shelby']['web']['nginx']['extension-cache']['expires'] = '48h'

default['shelby']['web']['nginx']['custom_locations'] = []