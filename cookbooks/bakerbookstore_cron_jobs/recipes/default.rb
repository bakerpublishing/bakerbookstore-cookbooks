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

  cron 'export_bookstore_manager_orders' do
    minute  '0' # Run on the hour, every hour
    user    'deploy'
    command "cd /data/bakerbookstore/current && RAILS_ENV=#{node[:environment][:framework_env]} bundle exec rake export:bookstore_manager:orders"
  end

  cron 'ingram_inventory_import' do
    minute  '0' # Run on the hour
    hour    '1,5,9,13,17,21' # On the hours listed
    user    'deploy'
    command "cd /data/bakerbookstore/current && RAILS_ENV=#{node[:environment][:framework_env]} bundle exec rake import:inventory:ingram:start"
  end

  cron 'bsm_inventory_import' do
    minute  '22' # Run 22 after the hour, every hour
    user    'deploy'
    command "cd /data/bakerbookstore/current && RAILS_ENV=#{node[:environment][:framework_env]} bundle exec rake import:inventory:bookstore_manager:start"
  end
end
