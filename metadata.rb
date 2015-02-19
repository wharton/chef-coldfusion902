maintainer       "The Wharton School - The University of Pennsylvania"
maintainer_email "goettnel@wharton.upenn.edu"
license          "Apache 2.0"
description      "Installs/Configures ColdFusion 9.0.2"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.3"
name             "coldfusion902"

%w{ ubuntu }.each do |os|
  supports os
end

depends "apt"
depends "apache2"

recipe "coldfusion902", "Includes the standalone and jvmconfig recipes"
recipe "coldfusion902::apache", "Configures ColdFusion to run behind the Apache httpd web server"
recipe "coldfusion902::configure", "Sets ColdFusion configuration settings via the config LWRP"
recipe "coldfusion902::jvmconfig", "Sets necessary JVM configuration"
recipe "coldfusion902::jws", "Sets webroot for the built in JRun web server (JWS)"
recipe "coldfusion902::standalone", "Installs ColdFusion 9.0.2 in standalone mode, included by default recipe"
recipe "coldfusion902::trustedcerts", "Imports certificates from a data bag into the JVM truststore"
recipe "coldfusion902::updates", "Applies CHF1, APSB13-13, and APSB13-19"


