template '/etc/nginx/servers/block_non_domain.conf' do
  owner 'deploy'
  group 'deploy'
  source 'block_non_domain.conf.erb'
  mode 0644
end

template '/etc/nginx/servers/block_non_domain.ssl.conf' do
  owner 'deploy'
  group 'deploy'
  source 'block_non_domain.ssl.conf.erb'
  mode 0644
end
