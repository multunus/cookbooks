include_recipe "main::monit"

monitrc "monit-nginx"
r = resources(:template => "/etc/monit/conf.d/monit-nginx.conf")
r.cookbook "main"

monitrc "redis"
r = resources(:template => "/etc/monit/conf.d/redis.conf")
r.cookbook "main"


# create an init script for unicorn

template "/etc/init.d/unicorn" do
  owner "root"
  group "root"
  mode 0755
  source 'unicorn-init.erb'
end

monitrc "unicorn"

r = resources(:template => "/etc/monit/conf.d/unicorn.conf")
r.cookbook "main"

monitrc "monitor-db-sync"
r = resources(:template => "/etc/monit/conf.d/monitor-db-sync.conf")
r.cookbook "main"


monitrc "monit-mysql"
r = resources(:template => "/etc/monit/conf.d/monit-mysql.conf")
r.cookbook "main"


service "monit"

