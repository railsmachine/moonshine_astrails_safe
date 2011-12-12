module Moonshine
  module AstrailsSafe
    def astrails_safe_template_dir
      Pathname.new(__FILE__).dirname.join('astrails_safe', 'templates')
    end

    # Define options for this plugin via the <tt>configure</tt> method
    # in your application manifest:
    #
    #   configure(:astrails_safe => {:foo => true})
    #
    # Then include the plugin and call the recipe(s) you need:
    #
    #  plugin :astrails_safe
    #  recipe :astrails_safe
  
    # setting defaults to make template a little cleaner
    def astrails_safe(options = {})
    
      options[:local]   ||= {}
      options[:mysql]   ||= {}
      options[:mongodb] ||= {}
      options[:gem] ||= {}
      gem 'astrails-safe', options[:gem]
      package 'gpg'

      file '/etc/astrails', :ensure => :directory, :mode => '644'
      file '/etc/astrails/safe.conf',
        :ensure => :present,
        :mode => '644',
        :require => file('/etc/astrails'),
        :content => template(astrails_safe_template_dir.join('safe.conf'), binding)

     # unless cron is  false, the default backup is every night at midnight
     unless options[:cron] == false
       options[:cron] ||= {}
       cron 'astrails-safe',
        :command    => options[:cron][:command] || 'astrails-safe /etc/astrails/safe.conf',
        :minute     => options[:cron][:minute] || 0,
        :hour       => options[:cron][:hour] || 0,
        :monthday   => options[:cron][:monthday] || '*',
        :month      => options[:cron][:month] || '*',
        :weekday    => options[:cron][:weekday] || '*',
        :user       => options[:cron][:user] || configuration[:user]
     end
    
    end
  
  end
end