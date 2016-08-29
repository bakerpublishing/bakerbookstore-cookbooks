le_api_key(node[:engineyard][:environment][:apps].first[:components].first[:collection].find { |c| c[:name] == 'logentries' }[:config][:vars][:LE_API_KEY])
# Read more at https://logentries.com/doc/engineyard/
