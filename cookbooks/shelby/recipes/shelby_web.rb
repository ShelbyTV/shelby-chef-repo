#
# Cookbook Name:: shelby
# Recipe:: shelby_web
#
# Copyright 2012, Shelby.tv
#
# All rights reserved - Do Not Redistribute
#
# Set up a server for the Shelby web app

node.set['shelby']['nginx']['app_name'] = 'shelby-gt-web'
node.set['shelby']['nginx']['app_deploy_folder'] = 'web'
node.set['shelby']['nginx']['upstream'] = 'shelby-web'
node.set['shelby']['nginx']['enable_ssl'] = true
node.set['shelby']['nginx']['certificate_file'] = "shelby.tv.pem"
node.set['shelby']['nginx']['key_file'] = "shelby.tv.key"
node.set['shelby']['nginx']['stub_status']['enable'] = true

# TODO: see if we can use this to replace all of our custom configuration
# node.set['shelby']['nginx']['autoconfigure_static_files'] = true

node.set['shelby']['nginx']['custom_directives'] = [
  "## rewrite www to non www host",
  "if ($host ~* www\\.(.*)) {",
  "  set $host_without_www $1;",
  "  rewrite ^(.*)$ http://$host_without_www$1 permanent; # $1 contains '/foo', not 'www.mydomain.com/foo'",
  "}",

  "## START mobile redirection code",
  "set $mobile_request false;",
  "set $mobile_cookie  \"\";",
  "set $subdomain \"\";",
  "",
  "if ($host ~* \"^(.+)\\.shelby\\.tv$\") {",
  "  set $subdomain $1;",
  "}",
  "",
  "if ($http_user_agent ~* '(iPhone|iPod|Android|WebOS)') {",
  "  set $mobile_request true;",
  "}",
  "",
  "if ($args ~ 'mobile=false') {",
  "  set $mobile_request false;",
  "  set $mobile_cookie  \"mobile=false\";",
  "}",
  "",
  "if ($args ~ 'mobile=true') {",
  "  set $mobile_request true;",
  "  set $mobile_cookie \"mobile=true\";",
  "}",
  "",
  "add_header Set-Cookie $mobile_cookie;",
  "",
  "if ($http_cookie ~ 'mobile=false') {",
  "  set $mobile_request false;",
  "}",
  "",
  "if ($subdomain ~ 'm') {",
  "  set $mobile_request false;",
  "}",
  "",
  "if ($mobile_request = true) {",
  "  rewrite ^ http://m.shelby.tv$request_uri? redirect;",
  "  break;",
  "}",
  "## END mobile redirection code"
]

node.set['shelby']['nginx']['custom_locations'] = [
    {
      :path => "= /assets/shelbify.js",
      :directives => [
        "root /home/gt/web/current/public;",
        node['shelby']['environment'] == 'production' ? "expires #{node['shelby']['web']['extension-cache']['expires']};" : nil,
        "gzip_static on;",
        node['shelby']['environment'] == 'production' ? "add_header Cache-Control public;" : nil
      ].compact
    },
    {
      :path => "= /assets/turbo.js",
      :directives => [
        "root /home/gt/web/current/public;",
        "expires 48h;",
        "gzip_static on;",
        "add_header Cache-Control public;"
      ]
    },
    #--- send cache expiry headers for static assets ---
    {
      :path => "~ ^/(assets|fonts|images|videos|javascripts|stylesheets|system)/",
      :directives => [
        "root /home/gt/web/current/public;",
        "gzip_static on;",
        "expires max;",
        "add_header Cache-Control public;"
      ]
    },
    {
      :path => "~* [.]html$",
      :directives => [
        "root /home/gt/web/current/public/html;",
        "gzip_static on;",
        "expires 24h;",
        "add_header Cache-Control public;"
      ]
    },
    {
      :path => "~ ^/favicon\.(ico|png)",
      :directives => [
        "root /home/gt/web/current/public;",
        "gzip_static on;",
        "expires max;",
        "add_header Cache-Control public;"
      ]
    },
    {
      :path => "^~ /robots.txt",
      :directives => [
        "root /home/gt/web/current/public;",
        "gzip_static on;",
        "expires max;",
        "add_header Cache-Control public;"
      ]
    },
    {
      :path => "~ ^/apple-touch-icon-precomposed.png",
      :directives => [
        "root /home/gt/web/current/public;",
        "gzip_static on;",
        "expires max;",
        "add_header Cache-Control public;"
      ]
    },
    {
      :path => "^~ /web-app-manifest.json",
      :directives => [
        "root /home/gt/web/current/public;",
        "#gzip_static on;",
        "#expires max;",
        "add_header Cache-Control public;"
      ]
    }
]

if node['shelby']['environment'] == 'production'
  node['shelby']['nginx']['custom_locations'].concat([
    {
      :path => "/blog/",
      :directives => [
        "proxy_pass http://shelbytv.tumblr.com/;"
      ]
    },
    {
      :path => "/setup/hangout",
      :directives => [
        "proxy_pass https://plus.google.com/hangouts/_/event/c2m29rk7h2gq3ms6qb6mimf2808?authuser=0&hl=en;"
      ]
    },
    {
      :path => "/sitemap_index.xml.gz",
      :directives => [
        "proxy_pass http://api.shelby.tv/system/sitemap_index.xml.gz;"
      ]
    }
  ])
end

include_recipe "shelby::shelby_user_rvm"
# we need Java for rails asset pipeline js minification with YUI
include_recipe "java"
include_recipe "shelby::shelby_nginx"
include_recipe "shelby::firewall_web_server"

if node['shelby']['environment'] == 'production'
  # support blog deep links b/c tumblr isn't designed for this
  nginx_app "blog.shelby.tv" do
    listen ['80']
    server_name "blog.shelby.tv"
    custom_directives [
      "rewrite ^ http://shelby.tv/blog$request_uri? permanent;",
    ]
  end
end