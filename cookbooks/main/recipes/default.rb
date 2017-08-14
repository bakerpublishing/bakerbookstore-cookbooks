include_recipe "timezone"
include_recipe "sidekiq"
include_recipe "redis-yml"
include_recipe "redis"
include_recipe "le"
include_recipe "ban"
include_recipe "nginx_block_non_domain"
include_recipe "ha_proxy_config"

#enable Extension modules for a given Postgresql database
if ['solo','db_master', 'db_slave'].include?(node[:instance_role])
  postgresql9_hstore 'bakerbookstore'
end

include_recipe "bakerbookstore_cron_jobs"
include_recipe "postgresql_maintenance"
