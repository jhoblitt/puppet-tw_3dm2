Puppet tw_3dm2 Module
=====================

[![Build Status](https://travis-ci.org/jhoblitt/puppet-tw_3dm2.png)](https://travis-ci.org/jhoblitt/puppet-tw_3dm2)

Description
-----------

This module downloads via wget, unzips, installs, and configures the 3ware
3dm2/tdm2 & tw_cli RAID controller management software


Examples
--------

    class{ 'tw_3dm2':
      package_filename  => '3DM2_CLI-Linux_10.2.1_9.5.4.zip',
      package_url       => 'http://example.org/3DM2_CLI-Linux_10.2.1_9.5.4.zip',
      emailserver       => 'mail.example.org',
    }

Copyright
---------

Copyright (C) 2012-2013 Joshua Hoblitt <jhoblitt@cpan.org>
