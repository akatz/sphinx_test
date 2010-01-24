appname = 'sphinxtest' #replace with your app's name
node = configuration[:node]

if node['instance_role'] == 'app'
  while (`curl -H "Host: #{node[:applications][appname][:vhosts][0][:name]}" #{node[:master_app_server][:private_dns_name]} -I 2>/dev/null| head -1 | awk '{print $2}'`.to_i == 503 )

    Chef::Log.info(
      "Testing: curl -H \"Host: #{node[:applications][appname][:vhosts][0][:name]}\" #{node[:master_app_server][:private_dns_name]} -I 2>/dev/null| head -1 | awk '{print $2}'"
    )
    sleep 5
  end
else
  sleep 60
end 
run <<-END
  if [ -f '#{shared_path}/system/maintenance.html' ] ; then
    rm #{shared_path}/system/maintenance.html
  fi
END

