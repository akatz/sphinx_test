execute "thinking sphinx index" do
  command "rake ts:in"
  user node[:owner_name]
  environment({
    'HOME' => "/home/#{node[:owner_name]}",
    'RAILS_ENV' => node[:environment][:framework_env]
  })
  cwd "/data/#{app.name}/current"
end