node = configuration[:node]
domain = 'sphinxtest.example.com'

if node['instance_role'] == 'app'
  while (`curl -H "Host: #{domain}" #{node[:master_app_server][:private_dns_name]} -I 2>/dev/null| head -1 | awk '{print $2}'`.to_i == 503 )
    sleep 5
  end
end 

require 'pp'
Chef::Log.info(configuration[:node].pretty_inspect)

run <<-END
  if [ -f '#{shared_path}/system/maintenance.html' ] ; then
    rm #{shared_path}/system/maintenance.html
  fi
END

