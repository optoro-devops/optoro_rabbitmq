# Description

Installs/Configures a single instance of rabbitmq server

# Requirements

## Platform:

*No platforms defined*

## Cookbooks:

* rabbitmq

# Attributes

* `node['rabbitmq']['ssl']` -  Defaults to `true`.
* `node['rabbitmq']['ssl_cacert']` -  Defaults to `/etc/rabbitmq/ssl/cacert.pem`.
* `node['rabbitmq']['ssl_cert']` -  Defaults to `/etc/rabbitmq/ssl/cert.pem`.
* `node['rabbitmq']['ssl_key']` -  Defaults to `/etc/rabbitmq/ssl/key.pem`.
* `node['rabbitmq']['use_distro_version']` -  Defaults to `false`.
* `node['optoro_rabbitmq']['pid']` -  Defaults to `/var/run/rabbitmq/pid`.

# Recipes

* optoro_rabbitmq::default
* optoro_rabbitmq::install

# License and Maintainer

Maintainer:: Optoro (<devops@optoro.com>)

License:: MIT
