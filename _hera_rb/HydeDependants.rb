load 'Dependants/InstallJekyll.rb'
load 'Dependants/InstallHaml.rb'
load 'Dependants/InstallSass.rb'
load 'Dependants/InstallJammit.rb'
load 'Dependants/InstallGuard.rb'
load 'Dependants/InstallGuardRake.rb'
load 'Dependants/InstallRbFsevent.rb'
load 'Dependants/InstallGrowlNotify.rb'

class HydeDependants
  def initialize
    install_jekyll
    install_haml
    install_sass
    install_jammit
    install_guard
    install_guard_rake
    install_rb_fsevent
    install_growl_notify
    install_complete
  end

  def install_jekyll
    jekyll = InstallJekyll.new
  end

  def install_haml
    haml = InstallHaml.new
  end

  def install_sass
    sass = InstallSass.new
  end

  def install_jammit
    jammit = InstallJammit.new
  end

  def install_guard
    guard = InstallGuard.new
  end

  def install_guard_rake
    guardRake = InstallGuardRake.new
  end

  def install_rb_fsevent
    rbFsevent = InstallRbFsevent.new
  end

  def install_growl_notify
    growlNotify = InstallGrowlNotify.new
  end

  def install_complete
    puts "You are all set, go forth and Hyde."
  end
end