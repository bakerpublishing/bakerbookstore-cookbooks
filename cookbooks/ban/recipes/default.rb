#
# Cookbook Name:: ban
# Recipe:: default
#

ban('rollbar_blacklist') do
  ip '64.20.33.203'
  ip '185.156.173.245'
end
