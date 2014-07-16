source 'https://rubygems.org'

gem 'chef', '~>11.10.0'
gem 'berkshelf'

# Uncomment these lines if you want to live on the Edge:
#
# group :development do
#   gem "berkshelf", github: "berkshelf/berkshelf"
#   gem "vagrant", github: "mitchellh/vagrant", tag: "v1.5.2"
# end
#
# group :plugins do
#   gem "vagrant-berkshelf", github: "berkshelf/vagrant-berkshelf"
#   gem "vagrant-omnibus", github: "schisamo/vagrant-omnibus"
# end

group :development, :test do
  gem 'chef-zero', '~>1.7'
  gem 'guard-kitchen'
  gem 'test-kitchen'
  gem 'kitchen-docker'
  gem 'kitchen-vagrant'
  gem 'knife-solo_data_bag'
end
