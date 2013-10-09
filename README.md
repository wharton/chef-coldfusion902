Description
===========

Sets up ColdFusion 9.0.2. Currently supports standalone server on 32bit Ubuntu Linux.

Requirements
============

Cookbooks
---------

* apt - The apt cookbook is required.
* apache2 - The apache2 cookbook is required if using the colfusion902::apache recipe.

Attributes
==========

For Installer Location
----------------------

_One_ of the following attributes should be set:

* `node['cf902']['installer']['url']` -  If defined, the installer will be downloaded from this location. (default: "http://download.macromedia.com/pub/coldfusion/cf9_installer/ColdFusion\_9\_WWEJ\_linux.bin")
* `node['cf902']['installer']['cookbook_file']` - If defined, a cookbook file with this name, i.e. "ColdFusion\_10\_WWEJ\_linux32.bin", must be available in this cookbook's `files/default` directory. You must download the installer from adobe.com and place it in this directory. (no default)
* `node['cf902']['installer']['local_file']` - If defined, the the installer binary must be available on the the chef node at this path, i.e. "/tmp/ColdFusion\_10\_WWEJ\_linux32.bin". This can be useful if you have some way to distribute the installer to chef nodes before provisioning. For example you may keep a single copy of the installer on your Vagrant host workstation and make it availble to all you Vagrant guests via a shared folder. (no default)

For ColdFusion
--------------

* `node['cf902']['install_path']` - ColdFusion installation path (default: "/opt/coldfusion9")
* `node['cf902']['admin_pw']` - ColdFusion administrator password (default: "vagrant")
* `node['cf902']['webroot']` - The document root to use for either Apache or theJRun Web Server (JWS) (default: "/vagrant/wwwroot") 
* `node['cf902']['java_home']` - Defaults to the JRE bundled with ColdFusion. Updated to system JAVA_HOME if the Java cookbook is used.

For Configuration
------------------------

* `node['cf902']['config_settings']` - A struct of config settings. (default: {})

ColdFusion configuration for this cookbook is handled by a LWRP wrapping the 
ColdFusion Configuration Manager project (https://github.com/nmische/cf-configmanager). 
To set ColdFusion admin settings via this cookbook set the config_settings as necessary
and include the coldfusion902::configure recipe in your run list. Below is a sample
JSON datasource definition:

    "config_settings" => {
      "datasource" => {
        "MSSql" => [
          {
            "name" => "MYDSN",
            "host" => "mydbserver",
            "database" => "mydb",
            "username" => "dbuser",
            "password" => "dbpassword",
            "sendStringParametersAsUnicode" => true,
            "disable_clob" => false,
            "disable_blob" => false,
          }
        ]
      }
    }

For Updates
-------------

* `node['cf902']['CHF1']['CF902']['url']` - Download location for update (default: "http://helpx.adobe.com/content/dam/help/en/coldfusion/kb/chf/CF902/CF902.zip")
* `node['cf902']['CHF1']['CFIDE-CF902']['url']` - Download location for update (default: "http://helpx.adobe.com/content/dam/help/en/coldfusion/kb/chf/CF902/CFIDE-902.zip")
* `node['cf902']['APSB13-13']['CF902']['url']` - Download location for update (default: "http://helpx.adobe.com/content/dam/help/en/coldfusion/kb/apsb13-13/partial/CF902.zip")
* `node['cf902']['APSB13-13']['CFIDE-CF902']['url']` - Download location for update (default: "http://helpx.adobe.com/content/dam/help/en/coldfusion/kb/apsb13-13/partial/CFIDE-902.zip")
 `node['cf902']['APSB13-19']['jar']['url']` - Download location for update (default: "http://helpx.adobe.com/content/dam/help/en/coldfusion/kb/apsb13-19/3329722.zip")
  
Usage
=====

On server nodes:

    include_recipe "coldfusion902"

This will run the `coldfusion902::standalone` , `coldfusion902::jvmconfig` and `coldfusion902::updates` recipes, 
installing ColdFusion 9.0.2 developer edition in standalone server mode.

For Trusted Certificates
------------------------

The trustedcerts recipe will look for a databag named `trusted_certs` with items that contain
certificates that should be added to the JVM trust store. The certificate should be a string with
new lines converted to `\n`s. Below is a sample that would be stored as `someCA.json`:

    { 
      "id" : "someCA",
      "certificate" : "-----BEGIN CERTIFICATE-----\n... truncated ...\n-----END CERTIFICATE-----"
    }

