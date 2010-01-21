require 'erb'

unless File.exists?("#{shared_path}/system/maintenance.html.tmp")
  template = File.read(File.join(File.dirname(__FILE__), "templates", "maintenance.rhtml")) 
  result = ERB.new(template).result(binding) 
  put result, "#{shared_path}/system/maintenance.html.tmp", :mode => 0644
end

run <<-END
  if [ -f '#{shared_path}/system/maintenance.html.custom' ] ; then
    cp #{shared_path}/system/maintenance.html.custom #{shared_path}/system/maintenance.html
  else
    cp #{shared_path}/system/maintenance.html.tmp #{shared_path}/system/maintenance.html
  fi
END

