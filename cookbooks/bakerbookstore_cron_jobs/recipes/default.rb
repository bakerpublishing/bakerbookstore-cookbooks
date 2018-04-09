#
# Cookbook Name:: bakerbookstore_cron_jobs
# Recipe:: default
#
Chef::Log.info "[bakerbookstore_cron_jobs] Adding cron jobs for BakerBookStore"

if node[:name] == 'Utility'
  cron 'import' do
    weekday '4' # Thursday
    hour    '20' # 8 pm
    minute  '0'
    user    'deploy'
    command "cd /data/bakerbookstore/current && RAILS_ENV=#{node[:environment][:framework_env]} bundle exec rake import:start"
  end

  if node[:environment][:framework_env] == 'production'
    cron 'export_bookstore_manager_orders' do
      minute  '0' # Run on the hour, every hour
      user    'deploy'
      command "cd /data/bakerbookstore/current && RAILS_ENV=#{node[:environment][:framework_env]} bundle exec rake export:bookstore_manager:orders"
    end
  end

  cron 'ingram_inventory_import' do
    minute  '0' # Run on the hour
    hour    '1,5,9,13,17,21' # On the hours listed
    user    'deploy'
    command "cd /data/bakerbookstore/current && RAILS_ENV=#{node[:environment][:framework_env]} bundle exec rake import:inventory:ingram:start"
  end

  cron 'bsm_inventory_import' do
    minute  '30' # Run 30 after the hour, every hour
    user    'deploy'
    command "cd /data/bakerbookstore/current && RAILS_ENV=#{node[:environment][:framework_env]} bundle exec rake import:inventory:bookstore_manager:start"
  end

  cron 'bsm_standalone_import' do
    weekday '0,1,2,3,4,6' # Everyday except Friday (since the BSM import is run during the full import on Thursday nights, into Friday mornings, we want to skip running this on Friday mornings)
    minute  '0' # Run on the hour
    hour    '3' # 3 am
    user    'deploy'
    command "cd /data/bakerbookstore/current && RAILS_ENV=#{node[:environment][:framework_env]} bundle exec rake import:bookstore_manager:start"
  end

  if node[:environment][:framework_env] == 'production'
    cron 'world_ship_export' do
      hour    '0'
      minute  '10' # Run every 10 minutes
      user    'deploy'
      command "cd /data/bakerbookstore/current && RAILS_ENV=#{node[:environment][:framework_env]} bundle exec rake export:worldship"
    end
  end
end

if node[:instance_role] == 'app_master' || node[:instance_role] == 'app'
  cron 'clean_tmp_directory' do
    weekday '0' # Sunday
    hour    '4' # 4 am
    minute  '0'
    user    'deploy'
    command "cd /data/bakerbookstore/current && RAILS_ENV=#{node[:environment][:framework_env]} bundle exec rake tmp:clear"
  end
end
