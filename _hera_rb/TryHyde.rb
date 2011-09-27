load "CheckRubyGem.rb"
load "HydeDependants.rb"

class TryHyde
  def initialize
    install_hyde
  end

  def install_hyde
    puts 'HYDE: Checking for Ruby.'
    if (system 'ruby --version')
      ruby_exists
    else
      prompt_ruby
    end
  end

  def ruby_exists
    puts 'HYDE: You have ruby, now checking for Gems.'
    checkForGem = CheckRubyGem.new

    if (checkForGem.check_for_ruby_gems == 'yes')
      puts 'HYDE: Rock!, you are good to go on the Hyde install.'
      call_dependants
    end

  end

  def prompt_ruby
    puts 'HYDE: Please install Ruby and run this install again.'
    puts 'HYDE: More information can be found at http://www.ruby-lang.org/en/'
    puts 'HYDE: You should also install ruby gems.'
    puts 'HYDE: More information can be found at http://rubygems.org/pages/download'
  end

  def prompt_ruby_gems
    puts 'HYDE: Sadly you dont have Gems installed, please install it and re-run Hyde.'
    puts 'HYDE: More information can be found at http://rubygems.org/pages/download'
  end

  def call_dependants
    hydeDependants = HydeDependants.new
  end

end

tryHyde = TryHyde.new