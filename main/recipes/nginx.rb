
include_recipe "nginx::commons"
node.set['nginx']['authorized_ips'] = ["182.73.101.46", "127.0.0.1/32"]


node.default['nginx']['source']['modules'] = [
  "nginx::http_ssl_module",
  "nginx::http_gzip_static_module",
  "nginx::http_stub_status_module"
]

include_recipe "nginx::source"



nginx_site "000-default" do
  enable false
end

nginx_site "messaging.contextmediahealth.com" do
  enable false
end

sites = node[:sites] || fail("please set :sites as a chef attribute")

sites.each do |url|
  template File.join(node[:nginx][:dir], "sites-available", url) do
    source "nginx.conf.erb"
    owner "root"
    group "root"
    mode "0644"
    variables(
      :public => File.join(node[:current_path], "public"),
      :application => node[:application],
      :url  =>  url
    )
  end

  nginx_site url
end

if node[:redis_bind_address]
  node.default["redisio"]['default_settings']["address"] = node[:redis_bind_address]
end

include_recipe "redisio::install"
include_recipe "redisio::enable"
