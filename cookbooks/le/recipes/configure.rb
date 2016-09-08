#
# Cookbook Name:: le
# Recipe:: configure
#

execute "le register --account-key" do
  command "/usr/bin/le register --account-key #{node[:le_api_key]} --name #{node[:applications].keys.first}"
  action :run
  not_if { File.exists?('/etc/le/config') }
end

follow_paths = [
  "/var/log/syslog",
  "/var/log/auth.log",
  "/var/log/daemon.log",
]

# ENV log path (e.g. staging.log or production.log)
(node[:applications] || []).each do |app_name, app_info|
  follow_paths << "/var/log/engineyard/apps/#{app_name}/#{node[:environment][:framework_env]}.log"
end

if ['app_master', 'app'].include?(node[:instance_role])
  (node[:applications] || []).each do |app_name, app_info|
    follow_paths << "/var/log/nginx/#{app_name}.access.log"
    follow_paths << "/var/log/nginx/#{app_name}.error.log"
    follow_paths << "/var/log/engineyard/apps/#{app_name}/unicorn.log"
    follow_paths << "/var/log/engineyard/apps/#{app_name}/unicorn.stderr.log"
  end
end

# Watch the log for each sidekiq worker
if ['util'].include?(node[:instance_role])
  (node[:applications] || []).each do |app_name, app_info|
    (0..(node[:sidekiq][:workers].to_i - 1)).each do |i|
    follow_paths << "/var/log/engineyard/apps/#{app_name}/sidekiq_#{i}.log"
    end
  end
end

follow_paths.each do |path|
  execute "le follow #{path}" do
    command "le follow #{path}"
    ignore_failure true
    action :run
    not_if "le followed #{path}"
  end
end
