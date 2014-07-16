# Serverspec tests for rabbitmq sensu configuration
require 'serverspec'

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS
RSpec.configure do |c|
  c.before :all do
    c.path = '/sbin:/usr/sbin'
  end
end

describe "Monit Daemon" do
  it "should be running" do
    expect(service("monit")).to be_running
  end
end

describe "Monit RabbitMQ configuration" do
  it "should exist" do
    expect(file("/etc/monit/conf.d/rabbitmq.conf")).to be_file
  end
end
