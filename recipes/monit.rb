template '/etc/monit/conf.d/rabbitmq.conf' do
  source 'rabbitmq.monitrc.erb'
  action :create
  owner 'root'
  group 'root'
  mode '600'
  notifies :run, 'execute[restart-monit]', :immediately
end
