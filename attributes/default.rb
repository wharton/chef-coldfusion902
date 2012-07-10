# CF Install folder
default['cf902']['install_path'] = "/opt/coldfusion9"
# CF Admin password
default['cf902']['admin_pw'] = "vagrant"
# JRun Web root
default['cf902']['webroot'] = "/vagrant/wwwroot"
# JVM
default['cf902']['java_home'] = "#{node['cf902']['install_path']}/runtime" 
# Trusted Certificates
default['cf902']['trusted_certs'] = {}
# Configuration 
default['cf902']['config_settings'] = {}
# Download Locations
default['cf902']['standalone']['cf902_installer']['url'] = "http://download.macromedia.com/pub/coldfusion/cf9_installer/ColdFusion_9_WWEJ_linux.bin"
default['cf902']['configmanager']['source']['url'] = "https://github.com/downloads/nmische/cf-configmanager/configmanager.zip"
