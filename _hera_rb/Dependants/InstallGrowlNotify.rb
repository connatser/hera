class InstallGrowlNotify
  def initialize
     puts 'Hyde: Installing Growl Notify.'
     system 'gem install growl_notify'
   end
end