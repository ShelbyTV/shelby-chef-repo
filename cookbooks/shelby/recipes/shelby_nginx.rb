#
# Cookbook Name:: shelby
# Recipe:: shelby_nginx
#
# Copyright 2012, Shelby.tv
#
# All rights reserved - Do Not Redistribute
#
# Install and congigure nginx to serve a web app with unicorn
# This should be as generic and configurable as possible
# Eventually we'll replace shelby_web_nginx.rb with this

node.set['nginx']['disable_robots_logging'] = false
node.set['nginx']['worker_processes'] = 1
node.set['nginx']['multi_accept'] = "on"
node.set['nginx']['tcp_nodelay'] = "off"

include_recipe "nginx::source"

nginx_app node['shelby']['nginx']['app_name'] do
  server_name node['ipaddress']
  listen node['shelby']['nginx']['listen']
  locations [
    {
      :path => "/",
      :directives => [
        "proxy_set_header X-Forwarded-Proto $scheme;",
        "proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;",
        "proxy_set_header X-Real-IP $remote_addr;",
        "proxy_set_header Host $host;",
        "proxy_redirect off;",
        "proxy_http_version 1.1;",
        "proxy_set_header Connection '';",
        "proxy_pass http://#{node['shelby']['nginx']['upstream']};"
      ]
    }
  ].concat node['shelby']['web']['nginx']['custom_locations']
  upstreams [
    {
      :name => "#{node['shelby']['nginx']['upstream']}",
      :servers => ["unix:/tmp/#{node['shelby']['nginx']['upstream']}.socket fail_timeout=0"]
    }
  ]
  keepalive_timeout 70
end

if node['shelby']['nginx']['enable_ssl']

  # create the directory to store the ssl certificates
  directory node['shelby']['nginx']['certificates_dir'] do
    owner "root"
    group "root"
    mode "0755"
    action :create
  end

  if node['shelby']['nginx']['self_signed_certificate']
    # if we're using a self-signed certificate, generate it if it does not already exist
    certificate_file = "#{node['shelby']['nginx']['certificates_dir']}/server.crt"
    key_file = "#{node['shelby']['nginx']['certificates_dir']}/server.key"

    if !(File.exist?(certificate_file) || File.exist?(key_file))
      node.set[:selfsigned_certificate][:destination] = node['shelby']['nginx']['certificates_dir']
      node.set[:selfsigned_certificate][:sslpassphrase] = "dontmatter"
      node.set[:selfsigned_certificate][:country] = "US"
      node.set[:selfsigned_certificate][:state] = "New York"
      node.set[:selfsigned_certificate][:city] = "New York"
      node.set[:selfsigned_certificate][:orga] = "Shelby TV, Inc."
      node.set[:selfsigned_certificate][:depart] = "Shelby Operations"
      node.set[:selfsigned_certificate][:cn] = "*"
      node.set[:selfsigned_certificate][:email] = "shelby.tv"

      include_recipe "selfsigned_certificate::default"
    end

  else
    # if we're not using a self-signed certificate, the certificate files must be contained in the cookbook files/default directory
    # and will be installed in the specified certificates directory

    certificate_file = "#{node['shelby']['nginx']['certificates_dir']}/#{node['shelby']['nginx']['certificate_file']}"
    key_file = "#{node['shelby']['nginx']['certificates_dir']}/#{node['shelby']['nginx']['key_file']}"

    # install the ssl certificates

    cookbook_file certificate_file do
      owner 'root'
      group 'root'
      mode 0600
    end

    cookbook_file key_file do
      owner 'root'
      group 'root'
      mode 0600
    end

  end

  nginx_app "#{node['shelby']['nginx']['app_name']}-ssl" do
    server_name node['ipaddress']
    listen ['443 ssl']
    locations [
      {
        :path => "/",
        :directives => [
          "proxy_set_header X-Forwarded-Proto https;",
          "proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;",
          "proxy_set_header X-Real-IP $remote_addr;",
          "proxy_set_header Host $host;",
          "proxy_redirect off;",
          "proxy_http_version 1.1;",
          "proxy_set_header Connection '';",
          "proxy_pass http://#{node['shelby']['nginx']['upstream']}-ssl;"
        ]
      }
    ].concat node['shelby']['web']['nginx']['custom_locations']
    upstreams [
      {
        :name => "#{node['shelby']['nginx']['upstream']}-ssl",
        :servers => ["unix:/tmp/#{node['shelby']['nginx']['upstream']}.socket fail_timeout=0"]
      }
    ]
    custom_directives [
      "ssl_certificate #{certificate_file};",
      "ssl_certificate_key #{key_file};",
      "ssl_session_timeout 10m;",
      "ssl_protocols  SSLv2 SSLv3 TLSv1;",
      "ssl_ciphers  HIGH:!aNULL:!MD5;",
      "ssl_prefer_server_ciphers   on;"
    ]
    keepalive_timeout 70
  end
end