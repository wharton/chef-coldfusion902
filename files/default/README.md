COOKBOOK FILES
==============

ColdFusion 9 Update 1 (9.0.2) 
-----------------------------
By default this cookbook is configured to download the ColdFusion 
9.0.2 installer, however if you will be using this cookbook 
frequently you may want to pre-download this installer and place it 
in this directory so chef doesn't have to download it every time 
you provision a server. This file is available from adobe.com, 
http://www.adobe.com/support/coldfusion/downloads_updates.html#cf9.

* ColdFusion_9_WWEJ_linux.bin

To use this cookbook file comment out the related 
`default['cf902']['standalone']` default attribute(s).
