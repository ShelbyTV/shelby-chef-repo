default['shelby']['user']['name'] = 'gt'

default['shelby']['user_rvm']['username'] = 'gt'
default['shelby']['user_rvm']['default_ruby'] = 'ruby-1.9.3'
default['shelby']['user_rvm']['rubies'] = ['ruby-1.9.3']
default['shelby']['user_rvm']['version'] = '1.16.14'
default['shelby']['user_rvm']['branch'] = 'none'

default['shelby']['web']['certificates']['dir'] = "/etc/nginx/certificates"
default['shelby']['web']['certificates']['install'] = true

#--- only caching extension/bookmarklet code for 2 days b/c we don't have cache busting
default['shelby']['web']['nginx']['extension-cache']['expires'] = '48h'
default['shelby']['web']['nginx']['custom_locations'] = []

default['shelby']['nginx']['app_name'] = 'web_app'
default['shelby']['nginx']['app_deploy_folder'] = 'web'
default['shelby']['nginx']['upstream'] = 'upstream'
default['shelby']['nginx']['listen_to'] = ['80 default_server', 'localhost']

default['shelby']['nginx']['autoconfigure_static_files'] = false

default['shelby']['nginx']['enable_ssl'] = false
default['shelby']['nginx']['certificates_dir'] = "/etc/nginx/certificates"
default['shelby']['nginx']['self_signed_certificate'] = false
default['shelby']['nginx']['certificate_file'] = "shelby.tv.pem"
default['shelby']['nginx']['key_file'] = "shelby.tv.key"

node.default['build_essential']['compiletime'] = true