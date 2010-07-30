# require 'pp'
# Chef::Log.info(node.pretty_inspect)

# Sleep while the master's maintenance page is present
# appname = shared_path.split('/')[2]
# node = configuration[:node]
# cmd = "curl -H \"Host: #{node[:applications][appname][:vhosts][0][:name]}\" #{node[:master_app_server][:private_dns_name]} -I 2>/dev/null| head -1 | awk '{print $2}'"
# if node['instance_role'] == 'app'
#   Chef::Log.info(cmd)
#   while (`#{cmd}`.to_i == 503 )
#     sleep 5
#     Chef::Log.info(cmd)
#   end
# end 
# 
# # Remove maintenance page if it exists.
# Chef::Log.info("Removing maintenance page (if it exists)")
# run <<-END
#   if [ -f '#{shared_path}/system/maintenance.html' ] ; then
#     mv -f #{shared_path}/system/maintenance.html #{shared_path}/system/maintenance.html.last
#   fi
# END

