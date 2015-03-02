# Serverspec tests for rabbitmq sensu configuration
require 'spec_helper'

describe 'RabbitMQ Daemon' do
  it 'is running' do
    expect(service('rabbitmq-server')).to be_running
  end
end

describe 'RabbitMQ user' do
  it 'exist' do
    expect(user('rabbitmq')).to exist
  end
end

describe 'RabbitMQ Management Console' do
  it 'is listening on port 15672' do
    expect(service('rabbitmq-server')).to be_running
  end
end

describe 'RabbitMQ configuration' do
  %w( cacert.pem cert.pem key.pem ).each do |pem_file|
    describe "#{pem_file}" do
      it 'exists' do
        expect(file("/etc/rabbitmq/ssl/#{pem_file}")).to be_file
      end
    end
  end

  it 'references the ssl certificates' do
    expect(file('/etc/rabbitmq/rabbitmq.config')).to contain('/etc/rabbitmq/ssl/cert.pem')
  end

  it 'creates a rabbitmq user' do
    expect(command('rabbitmqctl -q list_users | grep sensu | cut -f1').stdout).to match(/sensu/)
  end

  it 'sets permissions for a rabbitmq user' do
    expect(command('rabbitmqctl -q list_user_permissions sensu | grep sensu').stdout).to match(/\.\*/)
  end

end
