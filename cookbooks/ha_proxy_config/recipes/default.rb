execute "reload-haproxy" do
  command "sudo /etc/init.d/haproxy reload"
  action :nothing
end

execute "Comment out http check lines" do
  command "sudo sed -r '/option httpchk HEAD|http-check expect/ s/^#*/  #/' -i /etc/haproxy.cfg"
  only_if 'grep "^\s*\(option httpchk\|http-check expect\)" /etc/haproxy.cfg'
  notifies :run, resources(:execute => "reload-haproxy")
end
