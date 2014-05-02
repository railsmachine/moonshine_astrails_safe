# Moonshine_AstrailsSafe

### A plugin for [Moonshine](http://github.com/railsmachine/moonshine)

A plugin for installing and managing [astrails-safe](http://github.com/astrails/safe), a tool for backing up files and databases locally and to s3.

There are lots of options that can be set. If no options are given, the default behavior is to backup the application's @deploy_to@ directory to /backup every night at midnight.

Here are some other ways to configure the plugin in moonshine.yml:
  
    :astrails_safe:
      :local:
        :path: /home/user/bak # default is /home/rails/backup/:kind (mysqldump, archive)
      :cron:  # default is to run every night at midnight
        :monthday: */5 # backup every five days at midnight. can also use minute,hour,month,weekday
      :keep: # number of backups to keep before rotating out.
             # default is to keep them all
        :s3: 12
        :local: 3
      :gpg:
        :key: user@domain.com # public key to encrypt with. quick instructions in the astrails [readme](http://github.com/astrails/safe)
        :password: sekrit # symmetric encryption with a password instead of a public key
      :mysql: # default is to backup the database from database.yml as root, no password
        :databases:
          - app_db
          - other_db
        :user: backup
        :password: sekrit # can also set host, port, or socket
      :archives # default is to backup the application directory. 
                # to change, specify name, files, and optionally, path(s) to exclude
        - :name: app
          :files: /srv/myapp
          :exclude:
            - /srv/myapp/shared/log
            - /srv/myapp/system
        - :name: static_site
          :files: /srv/static
          :exclude: /srv/static/garbage
        

=== Instructions

* Install the plugin
    script/plugin install git://github.com/railsmachine/moonshine_astrails_safe.git
* Configure settings if needed
* Include the plugin and recipe(s) in your Moonshine manifest
    recipe :astrails_safe
    
***

Unless otherwise specified, all content copyright &copy; 2014, [Rails Machine, LLC](http://railsmachine.com)
