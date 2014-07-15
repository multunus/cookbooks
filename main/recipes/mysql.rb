include_recipe "mysql::client"
include_recipe "database"
include_recipe "database::mysql"
include_recipe "mysql"

node.default['mysql']['server_debian_password'] = node[:database_server_debian_passphrase]
node.default['mysql']['server_root_password'] = node[:database_server_root_passphrase]
node.default['mysql']['server_repl_password'] = node[:database_server_repl_passphrase]

if node["use_optimized_mysql_config"]
  node.set["mysql"]["tunable"]["tmp_table_size"] = "64M"
  node.set["mysql"]["tunable"]["max_heap_table_size"] = "64M"
  node.set["mysql"]["tunable"]["bulk_insert_buffer_size"] = "64M"
  node.set["mysql"]["tunable"]["query_cache_limit"] = "4M"
  node.set["mysql"]["tunable"]["long_query_time"] = "2"
  node.set["mysql"]["tunable"]["innodb_buffer_pool_size"] = "2048M"
end


include_recipe "mysql::server"
include_recipe "mysql::ruby"


database node[:database_name] do
  connection({:host => "localhost", :username => 'root', :password => node['mysql']['server_root_password']})
  provider Chef::Provider::Database::Mysql
  action :create
end

database_user node[:database_user_name] do
  connection({:host => "localhost", :username => 'root', :password => node['mysql']['server_root_password']})
  provider Chef::Provider::Database::MysqlUser
  password node[:database_passphrase]
  database_name node[:database_name]
  host node[:database_remote_ip_address] if node[:database_remote_ip_address]
  action [:create, :grant]
end
