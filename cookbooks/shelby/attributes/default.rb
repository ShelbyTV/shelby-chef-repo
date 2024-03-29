default['shelby']['user']['name'] = 'gt'

default['shelby']['environment'] = 'production'

default['shelby']['user_rvm']['username'] = 'gt'
default['shelby']['user_rvm']['default_ruby'] = 'ruby-1.9.3'
default['shelby']['user_rvm']['rubies'] = ['ruby-1.9.3']
default['shelby']['user_rvm']['version'] = '1.16.14'
default['shelby']['user_rvm']['branch'] = 'none'

default['shelby']['nginx']['custom_directives'] = []
default['shelby']['nginx']['custom_locations'] = []

default['shelby']['nginx']['app_name'] = 'web_app'
default['shelby']['nginx']['app_deploy_folder'] = 'web'
default['shelby']['nginx']['upstream'] = 'upstream'
default['shelby']['nginx']['listen_to'] = ['80 default_server', 'localhost']

default['shelby']['nginx']['autoconfigure_static_files'] = false

default['shelby']['nginx']['stub_status']['enable'] = false
default['shelby']['nginx']['stub_status']['port'] = '4040'

default['shelby']['nginx']['enable_ssl'] = false
default['shelby']['nginx']['certificates_dir'] = "/etc/nginx/certificates"
default['shelby']['nginx']['self_signed_certificate'] = false
default['shelby']['nginx']['certificate_file'] = "shelby.tv.pem"
default['shelby']['nginx']['key_file'] = "shelby.tv.key"

#--- only caching extension/bookmarklet code for 2 days b/c we don't have cache busting
default['shelby']['web']['extension-cache']['expires'] = '48h'

default['shelby']['firewall']['redis_allowed_sources'] = []
default['shelby']['firewall']['audrey2_allowed_sources'] = ['108.166.56.26', '198.61.235.104', '198.61.236.118', '166.78.255.147']

node.default['build_essential']['compiletime'] = true