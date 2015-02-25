# Serverspec tests for rabbitmq sensu configuration
require 'spec_helper'

describe 'RabbitMQ Daemon' do
  it 'is running' do
    expect(service('rabbitmq-server')).to be_running
  end

  xit 'is monitored by monit' do
    expect(service('rabbitmq-server')).to be_monitored_by('monit')
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
  [
    { name: 'cacert.pem', md5: 'acdcf130d04c5c3e6f5a453af7988e24' },
    { name: 'cert.pem', md5: 'd41d8cd98f00b204e9800998ecf8427e' },
    { name: 'key.pem', md5: 'd41d8cd98f00b204e9800998ecf8427e' }
  ].each do |pem_file|
    describe "#{pem_file[:name]}" do
      it 'exists and is in the correct location' do
        expect(file("/etc/rabbitmq/ssl/#{pem_file[:name]}")).to be_file
      end

      it 'contains the correct contents' do
        expect(file("/etc/rabbitmq/ssl/#{pem_file[:name]}").md5sum).to match(pem_file[:md5])
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
