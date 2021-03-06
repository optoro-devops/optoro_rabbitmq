#
# Cookbook Name:: optoro_rabbitmq
# Recipe:: install
#
# Copyright (C) 2014 Optoro Inc.
#
# All rights reserved - Do Not Redistribute
#

# Install rabbitmq server
include_recipe 'rabbitmq::default'
include_recipe 'rabbitmq::mgmt_console'

# Restart server if necessary
execute 'restart_rabbitmq' do # ~FC004
  command 'service rabbitmq-server restart'
  action :nothing
end

# Install certificates for SSL connections
directory "#{node['rabbitmq']['config_root']}/ssl" do
  action :create
end

certs = Chef::EncryptedDataBagItem.load('certificates', 'rabbitmq')
[
  { name: 'cacert.pem', data: certs['cacert'] },
  { name: 'cert.pem', data: certs['servercert'] },
  { name: 'key.pem', data: certs['serverkey'] }
].each do |key_data|
  file "#{node['rabbitmq']['config_root']}/ssl/#{key_data[:name]}" do
    content key_data[:data]
    action :create_if_missing
    notifies :run, 'execute[restart_rabbitmq]', :immediately
  end
end

# Add optoro-specific virtual hosts
node['optoro_rabbitmq']['virtualhosts'].each do |virtualhost|
  rabbitmq_vhost virtualhost do
    action :add
  end
end

# Add optoro-specific user accounts for RabbitMQ
node['optoro_rabbitmq']['enabled_users'].each do |user|
  rabbitmq_user user['name'] do
    password user['password']
    action :add
  end

  rabbitmq_user user['name'] do # ~FC022
    vhost user['vhost']
    permissions user['permissions']
    action :set_permissions
    only_if { user['permissions'] }
  end
end
