class CheckRubyGem
  def check_for_ruby_gems
    if (system 'gem --version')
      return 'yes'
    else
      return 'no'
    end
  end
end