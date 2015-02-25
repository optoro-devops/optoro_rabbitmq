# Serverspec tests for rabbitmq sensu configuration
require 'spec_helper'

describe 'Monit Daemon' do
  it 'should be running' do
    expect(service('monit')).to be_running
  end
end

describe 'Monit RabbitMQ configuration' do
  it 'should exist' do
    expect(file('/etc/monit/conf.d/rabbitmq.conf')).to be_file
  end
end
