# if node.engineyard == sphinx_instance
#   execute "update sphinx.yml for #{app.name}" do
#     command "cd /;ln -sfv /data/#{app.name}/shared/config/sphinx.yml /data/#{app.name}/current/config/sphinx.yml"
#   end
#   execute "sphinx config" do
# 
#     command "rake ts:configure"
#     user node[:owner_name]
#     environment({
#       'HOME' => "/home/#{node[:owner_name]}",
#       'RAILS_ENV' => node[:environment][:framework_env]
#     })
#     cwd "/data/#{app.name}/current"
#   end
#   execute "thinking sphinx index" do
#     command "rake ts:in"
#     user node[:owner_name]
#     environment({
#       'HOME' => "/home/#{node[:owner_name]}",
#       'RAILS_ENV' => node[:environment][:framework_env]
#     })
#     cwd "/data/#{app.name}/current"
#   end
#   execute "monit start sphinx_#{app.name}_3312"
# end

