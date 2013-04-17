#
# Cookbook Name:: coldfusion10
# Recipe:: install
#
# Copyright 2012, NATHAN MISCHE
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

# Backwards compatibility for older url attribute
if node['cf902']['standalone'] && node['cf902']['standalone']['cf902_installer'] && node['cf902']['standalone']['cf902_installer']['url'] 
  node.default['cf10']['installer']['url'] = node['cf902']['standalone']['cf902_installer']['url']
end

# Set up install folder with correct permissions
directory node['cf902']['install_path'] do
  owner "nobody"
  group "bin"
  mode 00755
  action :create
  not_if { File.exists?("#{node['cf902']['install_path']}/Adobe_ColdFusion_9_InstallLog.log") }
end

# Create the CF 9.0.2 properties file
template "#{Chef::Config['file_cache_path']}/cf902-installer.properties" do
  source "cf902-installer.properties.erb"
  mode "0644"
  owner "root"
  group "root"
  not_if { File.exists?("#{node['cf902']['install_path']}/Adobe_ColdFusion_9_InstallLog.log") }
end

# Download from a URL
if node['cf902']['installer'] && node['cf902']['installer']['url']

  file_name = node['cf902']['installer']['url'].split('/').last

  # Download CF 10
  remote_file "#{Chef::Config['file_cache_path']}/#{file_name}" do
    source node['cf902']['installer']['url']
    owner "nobody"
    mode 00755
    action :create_if_missing
    not_if { File.exists?("#{node['cf902']['install_path']}/Adobe_ColdFusion_9_InstallLog.log") }
  end

# Copy from cookbook file
elsif node['cf902']['installer'] && node['cf902']['installer']['cookbook_file']

  file_name = node['cf902']['installer']['cookbook_file']

  # Move the CF 10 installer
  cookbook_file "#{Chef::Config['file_cache_path']}/#{file_name}" do
    source file_name
    owner "nobody"
    mode 00744    
    not_if { File.exists?("#{node['cf902']['install_path']}/Adobe_ColdFusion_9_InstallLog.log") }
  end

# Copy from local file
elsif node['cf902']['installer'] && node['cf902']['installer']['local_file']

  file_name = node['cf902']['installer']['local_file'].split('/').last

  # Move the CF 10 installer
  execute "copy_cf902_installer" do
    command <<-COMMAND
      cp #{node['cf902']['installer']['local_file']} #{Chef::Config['file_cache_path']}
      chown "nobody" #{Chef::Config['file_cache_path']}/#{file_name}
      chmod 00744 #{Chef::Config['file_cache_path']}/#{file_name}
    COMMAND
    creates "#{Chef::Config['file_cache_path']}/#{file_name}"
    action :run
    cwd Chef::Config['file_cache_path']
    not_if { File.exists?("#{node['cf902']['install_path']}/Adobe_ColdFusion_9_InstallLog.log") }
  end

# Throw an error if we can't find the installer
else

  Chef::Application.fatal!("You must define either a cookbook file, local file, or url for the ColdFusion 9.0.2 installer!")

end

# Run the CF 9.0.2 installer
execute "run_cf902_installer" do
  command "#{Chef::Config['file_cache_path']}/#{file_name} -f #{Chef::Config['file_cache_path']}/cf902-installer.properties"
  creates "#{node['cf902']['install_path']}/Adobe_ColdFusion_9_InstallLog.log"
  action :run
  user "root"
  cwd "#{Chef::Config['file_cache_path']}"
end


