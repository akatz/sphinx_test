#if node['instance_role'] == 'app'
#  while (`curl 
#  loop { curl master }
#end 

require 'pp'
Chef::Log.info(configuration[:node].pretty_inspect)

run <<-END
  if [ -f '#{shared_path}/system/maintenance.html' ] ; then
    rm #{shared_path}/system/maintenance.html
  fi
END

