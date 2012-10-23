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

# Create the CF 9.0.2 properties file
template "#{Chef::Config['file_cache_path']}/cf902-installer.properties" do
  source "cf902-installer.properties.erb"
  mode "0644"
  owner "root"
  group "root"
  not_if { File.exists?("#{node['cf902']['install_path']}/Adobe_ColdFusion_9_InstallLog.log") }
end


if node['cf902']['standalone'] && node['cf902']['standalone']['cf902_installer']

  # Download CF 9.0.2
  remote_file "#{Chef::Config['file_cache_path']}/ColdFusion_9_WWEJ_linux.bin" do
    source "#{node['cf902']['standalone']['cf902_installer']['url']}"
    action :create_if_missing
    mode "0744"
    owner "root"
    group "root"
    not_if { File.exists?("#{node['cf902']['install_path']}/Adobe_ColdFusion_9_InstallLog.log") }
  end

else

  # Move the CF 9.0.2 installer
  cookbook_file "#{Chef::Config['file_cache_path']}/ColdFusion_9_WWEJ_linux.bin" do
    source "ColdFusion_9_WWEJ_linux.bin"
    mode "0744"
    owner "root"
    group "root"
    not_if { File.exists?("#{node['cf902']['install_path']}/Adobe_ColdFusion_9_InstallLog.log") }
  end

end

# Run the CF 9.0.2 installer
execute "run_cf902_installer" do
  command "#{Chef::Config['file_cache_path']}/ColdFusion_9_WWEJ_linux.bin -f #{Chef::Config['file_cache_path']}/cf902-installer.properties"
  creates "#{node['cf902']['install_path']}/Adobe_ColdFusion_9_InstallLog.log"
  action :run
  user "root"
  cwd "#{Chef::Config['file_cache_path']}"
end

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
