node.override[:monit][:mailserver][:host] = node[:mail_host]
node.override[:monit][:mailserver][:port] = node[:mail_port]
node.override[:monit][:mailserver][:username] = node[:mail_user_name]
node.override[:monit][:mailserver][:password] = node[:mail_passphrase]
node.override[:monit][:mail_format][:from] = node[:monit][:mail_from]
node.override[:monit][:mail_format][:to] = node[:monit][:to]

include_recipe "monit"
include_recipe "monit::ubuntu12fix"
include_recipe "monit::ssh"

r = resources(:template => "/etc/monit/monitrc")
r.cookbook "main"

r = resources(:template => "/etc/monit/conf.d/ssh.conf")
r.cookbook "main"
