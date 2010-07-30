#
# Cookbook Name:: sphinx
# Recipe:: default
#

# Set your application name here
appname = "appname"

# Uncomment the flavor of sphinx you want to use
flavor = "thinking_sphinx"
#flavor = "ultrasphinx"

# If you want to have scheduled reindexes in cron, enter the minute
# interval here. This is passed directly to cron via /, so you should
# only use numbers between 1 - 59.
#
# If you don't want scheduled reindexes, just leave this commented.
#
# Uncommenting this line as-is will reindex once every 10 minutes.
 cron_interval = 10

if ['solo', 'app', 'app_master'].include?(node[:instance_role])
  sphinx_instance = if node.engineyard.environment.solo_cluster?
    node.engineyard.environment.instances.first
  else
    node.engineyard.environment.utility_instances.find {|x| x.name == "sphinx"}
  end

  if node.engineyard == sphinx_instance
    Chef::Log.info "Util server is #{sphinx_instance.id}"

     node.engineyard.apps.each do |app|

      template "/data/#{app.name}/shared/config/sphinx.yml" do
        owner node[:owner_name]
        group node[:owner_name]
        mode 0644
        variables({:sphinx_ip => sphinx_instance.public_hostname})
        source "sphinx.yml.erb"
      end

      execute "update sphinx.yml for #{app.name}" do
        command "cd /;ln -sfv /data/#{app.name}/shared/config/sphinx.yml /data/#{app.name}/current/config/sphinx.yml"
      end

          directory "/var/run/sphinx" do
            owner node[:owner_name]
            group node[:owner_name]
            mode 0755
          end

          directory "/var/log/engineyard/sphinx/#{app.name}" do
            recursive true
            owner node[:owner_name]
            group node[:owner_name]
            mode 0755
          end
          directory "/data/#{app.name}/shared/config/#{flavor.split("_").join("")}" do
            owner node[:owner_name]
            group node[:owner_name]
            mode 0755
          end
          execute "ln -sfv /data/#{app.name}/shared/config/#{flavor.split("_").join("")} /data/#{app.name}/current/config/#{flavor.split("_").join("")} " do 
            action :run 
          end
          remote_file "/etc/logrotate.d/sphinx" do
            owner "root"
            group "root"
            mode 0755
            source "sphinx.logrotate"
            backup false
            action :create
          end

          template "/etc/monit.d/sphinx.#{app.name}.monitrc" do
            source "sphinx.monitrc.erb"
            owner node[:owner_name]
            group node[:owner_name]
            mode 0644
            variables({
              :app_name => app.name,
              :user => node[:owner_name],
              :flavor => flavor
            })
          end

          template "/data/#{app.name}/shared/config/sphinx.yml" do
            owner node[:owner_name]
            group node[:owner_name]
            mode 0644
            source "sphinx.yml.erb"
            variables({
              :app_name => app.name,
              :user => node[:owner_name],
              :flavor => flavor.eql?("thinking_sphinx") ? "thinkingsphinx" : flavor,
              :mem_limit => 32
            })
          end

        #   execute "chown_sphinx" do
        #   # command "chown #{node[:owner_name]}:#{node[:owner_name]} -R /data/sphinx"
        # end
          execute "log rake taks" do
            command "rake -T >> /tmp/rake_tasks.out"
            cwd "/data/#{app.name}/current"
          end
          execute "sphinx config" do
            
            command "rake #{flavor}:configure"
            user node[:owner_name]
            environment({
              'HOME' => "/home/#{node[:owner_name]}",
              'RAILS_ENV' => node[:environment][:framework_env]
            })
            cwd "/data/#{app.name}/current"
          end

          execute "#{flavor} index" do
            command "rake #{flavor}:index"
            user node[:owner_name]
            environment({
              'HOME' => "/home/#{node[:owner_name]}",
              'RAILS_ENV' => node[:environment][:framework_env]
            })
            cwd "/data/#{app.name}/current"
          end

          execute "monit reload" do
          action :run
          end

          if cron_interval
            cron "sphinx index" do
              action  :create
              minute  "*/#{cron_interval}"
              hour    '*'
              day     '*'
              month   '*'
              weekday '*'
              command "cd /data/#{app.name}/current && RAILS_ENV=#{node[:environment][:framework_env]} rake #{flavor}:index"
              user node[:owner_name]
            end
          
            else

           node.engineyard.apps.each do |app|

            template "/data/#{app.name}/shared/config/sphinx.yml" do
              owner node[:owner_name]
              group node[:owner_name]
              mode 0644
              variables({:sphinx_ip => sphinx_instance.public_hostname})
              source "sphinx.yml.erb"
            end

            execute "update sphinx.yml for #{app.name}" do
              command "cd /;ln -sfv /data/#{app.name}/shared/config/sphinx.yml /data/#{app.name}/current/config/sphinx.yml"
            end
        
            execute "monit-reload" do
              command "monit reload"
              action :run
            end
           end
            end
     end
  end
end