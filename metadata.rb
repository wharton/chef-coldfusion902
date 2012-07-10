maintainer       "The Wharton School - The University of Pennsylvania"
maintainer_email "goettnel@wharton.upenn.edu"
license          "Apache 2.0"
description      "Installs/Configures ColdFusion 9.0.2"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.2"

supports 'ubuntu', '= 10.04'
supports 'ubuntu', '>= 11.04'

recipe "coldfusion9", "Includes the standalone recipe"
recipe "coldfusion9::apache", "Configures ColdFusion to run behind the Apache httpd web server"
recipe "coldfusion9::configure", "Sets ColdFusion configuration settings via the config LWRP"
recipe "coldfusion9::jvmconfig", "Sets necessary JVM configuration, included by default recipe"
recipe "coldfusion9::standalone", "Installs ColdFusion 9.0.1 in standalone mode, included by default recipe"
recipe "coldfusion9::trustedcerts", "Imports configured certificates into the JVM truststore"


