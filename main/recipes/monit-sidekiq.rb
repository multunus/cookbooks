include_recipe "main::monit"

# create an init script for sidekiq

template "/etc/init.d/sidekiq" do
  owner "root"
  group "root"
  mode 0755
  source 'sidekiq-init.erb'
  variables({
    :environment => node[:sidekiq_env]
  })
end

monitrc "sidekiq"
r = resources(:template => "/etc/monit/conf.d/sidekiq.conf")
r.cookbook "main"

service "monit"
