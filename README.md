Description
===========

Sets up ColdFusion 9.0.2. Currently supports standalone server on 32bit Linux.

Requirements
============

Cookbooks
---------

* apt - The apt cookbook is required.
* apache2 - The apache2 cookbook is required if using the colfusion902::apache recipe.

Attributes
==========

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

For Downlaods
-------------

* `node['cf902']['standalone']['cf902_installer']['url']` - URL for ColdFusion 9.0.2 installer (default: "http://download.macromedia.com/pub/coldfusion/cf9_installer/ColdFusion_9_WWEJ_linux.bin")
* `node['cf902']['configmanager']['source']['url']` - Source for cf-configmanger (default: "https://github.com/downloads/nmische/cf-configmanager/configmanager.zip")
  
Usage
=====

On server nodes:

    include_recipe "coldfusion902"

This will run the `coldfusion902::standalone` and `coldfusion902::jvmconfig` recipes, 
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

