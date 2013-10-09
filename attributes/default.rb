# Installer locations, one of these must be defined
default['cf902']['installer']['url'] = "http://download.macromedia.com/pub/coldfusion/cf9_installer/ColdFusion_9_WWEJ_linux.bin"
# default['cf902']['installer']['cookbook_file'] = "ColdFusion_10_WWEJ_linux32.bin"
# default['cf902']['installer']['local_file'] = "/tmp/ColdFusion_10_WWEJ_linux32.bin"

# CF Install folder
default['cf902']['install_path'] = "/opt/coldfusion9"
# CF Admin password
default['cf902']['admin_pw'] = "vagrant"
# JRun Web root
default['cf902']['webroot'] = "/vagrant/wwwroot"
# JVM
default['cf902']['java_home'] = "#{node['cf902']['install_path']}/runtime" 
# Configuration 
default['cf902']['config_settings'] = {}
# Download Locations
default['cf902']['CHF1']['CF902']['url'] = "http://helpx.adobe.com/content/dam/help/en/coldfusion/kb/chf/CF902/CF902.zip"
default['cf902']['CHF1']['CFIDE-CF902']['url'] = "http://helpx.adobe.com/content/dam/help/en/coldfusion/kb/chf/CF902/CFIDE-902.zip"
default['cf902']['APSB13-13']['CF902']['url'] = "http://helpx.adobe.com/content/dam/help/en/coldfusion/kb/apsb13-13/partial/CF902.zip"
default['cf902']['APSB13-13']['CFIDE-CF902']['url'] = "http://helpx.adobe.com/content/dam/help/en/coldfusion/kb/apsb13-13/partial/CFIDE-902.zip"
default['cf902']['APSB13-19']['jar']['url'] = "http://helpx.adobe.com/content/dam/help/en/coldfusion/kb/apsb13-19/3329722.zip"