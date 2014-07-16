# Serverspec tests for rabbitmq sensu configuration
require 'serverspec'

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS
RSpec.configure do |c|
  c.before :all do
    c.path = '/sbin:/usr/sbin'
  end
end

describe "RabbitMQ Daemon" do
  it "should be running" do
    expect(service("rabbitmq-server")).to be_running
  end

  it "should be monitored by monit" do
    expect(service("rabbitmq-server")).to be_monitored_by("monit")
  end
end

describe "RabbitMQ user" do
  it "should exist" do
    expect(user("rabbitmq")).to exist
  end
end

describe "RabbitMQ Management Console" do
  it "should be listening on port 15672" do
    expect(service("rabbitmq-server")).to be_running
  end
end

describe "RabbitMQ configuration" do
  [ { name: "cacert.pem", md5: "81c0b4c2e96e5fde62dff810931fa514" },
    { name: "cert.pem", md5: "4b5d53b4e8ae11b9ac3ce3c7abea99fc" },
    { name: "key.pem", md5: "e65b3466dfc7c6536340f751512ac11b" }
  ].each do |pem_file|
    describe "#{pem_file[:name]}" do
      it "should exist and be in the correct location" do
        expect(file("/etc/rabbitmq/ssl/#{pem_file[:name]}")).to be_file
      end

      it "should contain the correct contents" do
        expect(file("/etc/rabbitmq/ssl/#{pem_file[:name]}")).to match_md5checksum(pem_file[:md5])
      end
    end
  end

  it "rabbitmq.config should reference the ssl certificates" do
    expect(file("/etc/rabbitmq/rabbitmq.config")).to contain("/etc/rabbitmq/ssl/cert.pem")
  end

  it "should create a rabbitmq user" do
    expect(command("rabbitmqctl -q list_users | grep sensu | cut -f1")).to return_stdout("sensu")
  end

end
