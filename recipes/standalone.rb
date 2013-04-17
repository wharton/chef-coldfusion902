#
# Cookbook Name:: coldfuison9
# Recipe:: standalone
#
# Copyright 2012, Lew Goettner, Nathan Mische
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Run the installer
include_recipe "coldfusion902::install"

# Link the init script
link "/etc/init.d/coldfusion" do
  to "#{node['cf902']['install_path']}/bin/coldfusion"
end

# Set up CF as a service for CF 9.0.2 installation
service "coldfusion" do  
  supports :restart => true
  action :enable
end

# Create the webroot if it doesn't exist
directory "#{node['cf902']['webroot']}" do
  owner "vagrant"
  group "vagrant"
  mode "0755"
  action :create
  not_if { File.directory?("#{node['cf902']['webroot']}") }
end
