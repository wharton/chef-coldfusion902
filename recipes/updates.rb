#
# Cookbook Name:: coldfusion902
# Recipe:: updates
#
# Copyright 2013, Nathan Mische
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

# Stop CF
execute "stop_cf_for_coldfusion902_updates" do
  command "/bin/true"
  not_if { File.exists?("#{node['cf902']['install_path']}/lib/updates/chf9020001.jar") && File.exists?("#{node['cf902']['install_path']}/lib/updates/hf902-00004.jar") }
  notifies :stop, "service[coldfusion]", :immediately
end

# First install cumulative hot fix 1 ColdFusion 9.0.2
# http://helpx.adobe.com/coldfusion/kb/cumulative-hotfix-1-coldfusion-902.html

directory "#{Chef::Config['file_cache_path']}/CHF1" do
  action :create
  not_if { File.exists?("#{node['cf902']['install_path']}/lib/updates/chf9020001.jar") }
end

remote_file "#{Chef::Config['file_cache_path']}/CHF1/CF902.zip" do
  source "#{node['cf902']['CHF1']['CF902']['url']}"
  action :create
  mode "0744"
  owner "root"
  group "root"
  not_if { File.exists?("#{node['cf902']['install_path']}/lib/updates/chf9020001.jar") }
end

remote_file "#{Chef::Config['file_cache_path']}/CHF1/CFIDE-CF902.zip" do
  source "#{node['cf902']['CHF1']['CFIDE-CF902']['url']}"
  action :create
  mode "0744"
  owner "root"
  group "root"
  not_if { File.exists?("#{node['cf902']['install_path']}/lib/updates/chf9020001.jar") }
end

script "install_CHF1" do
  interpreter "bash"
  user "root"
  cwd "#{Chef::Config['file_cache_path']}/CHF1"
  code <<-EOH
  unzip CF902.zip
  cp CF902/lib/updates/chf9020001.jar #{node['cf902']['install_path']}/lib/updates   
  unzip -o CFIDE-902.zip -d #{node['cf902']['install_path']}/wwwroot
  cp -f CF902/lib/*.jar #{node['cf902']['install_path']}/lib 
  chown -R nobody:bin #{node['cf902']['install_path']}/wwwroot
  chown -R nobody:bin #{node['cf902']['install_path']}/lib
  rm -fR CF902
  EOH
  not_if { File.exists?("#{node['cf902']['install_path']}/lib/updates/chf9020001.jar") }
  notifies :restart, "service[coldfusion]", :delayed
end

directory "#{Chef::Config['file_cache_path']}/CHF1" do
  action :delete
  recursive true
end

# Next install APSB13-13
# http://www.adobe.com/support/security/bulletins/apsb13-13.html
# http://helpx.adobe.com/coldfusion/kb/coldfusion-security-hotfix-apsb13-13.html

%w{ hf902-00001.jar hf902-00002.jar hf902-00003.jar hf902-00004.jar }.each do |hf|
	file "#{node['cf902']['install_path']}/lib/updates/#{hf}" do
		action :delete
	end
end

directory "#{Chef::Config['file_cache_path']}/APSB13-13" do
  action :create
  not_if { File.exists?("#{node['cf902']['install_path']}/lib/updates/hf902-00005.jar") }
end

remote_file "#{Chef::Config['file_cache_path']}/APSB13-13/CF902.zip" do
  source "#{node['cf902']['APSB13-13']['CF902']['url']}"
  action :create
  mode "0744"
  owner "root"
  group "root"
  not_if { File.exists?("#{node['cf902']['install_path']}/lib/updates/hf902-00005.jar") }
end

remote_file "#{Chef::Config['file_cache_path']}/APSB13-13/CFIDE-CF902.zip" do
  source "#{node['cf902']['APSB13-13']['CFIDE-CF902']['url']}"
  action :create
  mode "0744"
  owner "root"
  group "root"
  not_if { File.exists?("#{node['cf902']['install_path']}/lib/updates/hf902-00005.jar") }
end

script "install_APSB13-13" do
  interpreter "bash"
  user "root"
  cwd "#{Chef::Config['file_cache_path']}/APSB13-13"
  code <<-EOH
  unzip CF902.zip
  cp CF902/lib/updates/hf902-00005.jar #{node['cf902']['install_path']}/lib/updates   
  unzip -o CFIDE-902.zip -d #{node['cf902']['install_path']}/wwwroot
  chown -R nobody:bin #{node['cf902']['install_path']}/wwwroot
  chown -R nobody:bin #{node['cf902']['install_path']}/lib
  rm -fR CF902
  EOH
  not_if { File.exists?("#{node['cf902']['install_path']}/lib/updates/hf902-00005.jar") }
  notifies :restart, "service[coldfusion]", :delayed
end

directory "#{Chef::Config['file_cache_path']}/APSB13-13" do
  action :delete
  recursive true
end


# Next install APSB13-19
# http://www.adobe.com/support/security/bulletins/apsb13-19.html
# http://helpx.adobe.com/coldfusion/kb/coldfusion-security-hotfix-apsb13-19.html

directory "#{Chef::Config['file_cache_path']}/APSB13-19" do
  action :create
  not_if { File.exists?("#{node['cf902']['install_path']}/runtime/servers/lib/jrun-hotfix-3329722.jar") }
end

remote_file "#{Chef::Config['file_cache_path']}/APSB13-19/3329722.zip" do
  source "#{node['cf902']['APSB13-19']['jar']['url']}"
  action :create
  mode "0744"
  owner "root"
  group "root"
  not_if { File.exists?("#{node['cf902']['install_path']}/runtime/servers/lib/jrun-hotfix-3329722.jar") }
end

script "install_APSB13-19" do
  interpreter "bash"
  user "root"
  cwd "#{Chef::Config['file_cache_path']}/APSB13-19"
  code <<-EOH
  unzip 3329722.zip
  cp 3329722/jrun-hotfix-3329722.jar #{node['cf902']['install_path']}/runtime/servers/lib 
  rm -fR 3329722
  EOH
  not_if { File.exists?("#{node['cf902']['install_path']}/runtime/servers/lib/jrun-hotfix-3329722.jar") }
  notifies :restart, "service[coldfusion]", :delayed
end

directory "#{Chef::Config['file_cache_path']}/APSB13-19" do
  action :delete
  recursive true
end






