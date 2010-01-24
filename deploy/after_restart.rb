# Sleep while the master's maintenance page is present
appname = shared_path.split('/')[2]
node = configuration[:node]
cmd = "curl -H \"Host: #{node[:applications][appname][:vhosts][0][:name]}\" #{node[:master_app_server][:private_dns_name]} -I 2>/dev/null| head -1 | awk '{print $2}'"
if node['instance_role'] == 'app'
  while (`#{cmd}`.to_i == 503 )
    Chef::Log.info(cmd)
    sleep 5
  end
else
  sleep 20
end 

require 'pp'
Chef::Log.info(node.pretty_inspect)

# Remove maintenance page if it exists.
run <<-END
  if [ -f '#{shared_path}/system/maintenance.html' ] ; then
    rm #{shared_path}/system/maintenance.html
  fi
END

