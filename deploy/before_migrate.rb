require 'erb'

unless File.exists?("#{shared_path}/system/maintenance.html.tmp")
  template = File.read(File.join(release_path, "deploy", "templates", "maintenance.rhtml")) 
  result = ERB.new(template).result(binding) 
  File.open("#{shared_path}/system/maintenance.html.tmp", 'w', 0644) {|f|
    f.puts result
  }
end

run <<-END
  if [ -f '#{shared_path}/system/maintenance.html.custom' ] ; then
    cp #{shared_path}/system/maintenance.html.custom #{shared_path}/system/maintenance.html
  else
    cp #{shared_path}/system/maintenance.html.tmp #{shared_path}/system/maintenance.html
  fi
END

