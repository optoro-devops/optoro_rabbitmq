#
# Cookbook Name:: optoro_rabbitmq
# Recipe:: default
#
# Copyright (C) 2014 Optoro Inc.
#
# All rights reserved - Do Not Redistribute
#

# Install rabbitmq server
include_recipe 'optoro_monit::rabbitmq'
include_recipe 'optoro_rabbitmq::install'
