#
# Cookbook Name:: shelby
# Recipe:: shelby_web_production
#
# Copyright 2012, Shelby.tv
#
# All rights reserved - Do Not Redistribute
#
# Set up a production server for the Shelby web app

# some special redirects for the production shelby.tv environment
node['shelby']['web']['nginx']['custom_locations'] = [
  #--- host blog at shelby.tv/blog ---
  {
    :path => "/blog/",
    :directives => [
      "proxy_pass http://shelbytv.tumblr.com/;"
    ]
  },
  #--- offer a shelby.tv-based sitemap index URL to play nicely with Google Webmaster Tools ---
  {
    :path => "/sitemap_index.xml.gz",
    :directives => [
      "proxy_pass http://api.shelby.tv/system/sitemap_index.xml.gz;"
    ]
  }
]

include_recipe "shelby::shelby_web"

# support blog deep links b/c tumblr isn't designed for this
nginx_app "blog.shelby.tv" do
  listen ['80']
  server_name "blog.shelby.tv"
  custom_directives [
    "rewrite ^ http://shelby.tv/blog$request_uri? permanent;",
  ]
end