class InstallGuard
  def initialize
     puts 'Hyde: Installing Guard.'
     system 'gem install guard'
   end
end