#
# Cookbook Name:: bakerbookstore_cron_jobs
# Recipe:: default
#
Chef::Log.info "[bakerbookstore_cron_jobs] Adding cron jobs for BakerBookStore"

if node[:name] == 'Utility'
  cron 'import' do
    day '4' # Thursday
    hour '20' # 8 pm
    minute '0'
    user 'deploy'
    command "cd /data/bakerbookstore/current && RAILS_ENV=#{node[:environment][:framework_env]} bundle exec rake import:start"
  end
end
