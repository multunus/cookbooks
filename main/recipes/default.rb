include_recipe "mysql::client"

#SSH Configuration 

include_recipe "ssh"

ssh_config "Port" do
  string "Port 26487"
end

gem_package "bundler"



include_recipe "fail2ban"
r = resources(:template => "/etc/fail2ban/jail.conf")
r.cookbook "main"


include_recipe "iptables"
iptables_rule "iptables"



