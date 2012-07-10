DESCRIPTION
===========

Sets up ColdFusion 9.0.2. Currently supports standalone server on 32bit Linux.

REQUIREMENTS
============

The apache2 cookbook is required if using the colfusion902::apache recipe.

ATTRIBUTES
==========

For ColdFusion
--------------

* `node['cf902']['install_path']` - ColdFusion installation path (default: "/opt/coldfusion9")
* `node['cf902']['admin_pw']` - ColdFusion administrator password (default: "vagrant")
* `node['cf902']['webroot']` - The built in JRun Web Server (JWS) web root (default: "/vagrant/wwwroot") 
  Note: the cookbook will attempt to create this directory if it does not exist.
* `node['cf902']['java_home']` - Defaults to the JRE bundled with ColdFusion. Updated to system JAVA_HOME if the Java cookbook is used.


For Trusted Certificates
------------------------

* `node['cf902']['trustedcerts']` - A struct of trusted certificates (default: {})

The struct should contain a key, which will be used as the alias when importing the cert
into the cacerts keystore. The value of the key should be the name of a certificate file
found in the cookbook files. Below is a sample JSON trustedcerts definition:

    "trustedcerts" => {
      "mycert" => "mycert.cer"
      }
    }


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
  