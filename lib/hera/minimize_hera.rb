#!/usr/bin/env ruby

class MinimizeHera
  def initialize

    puts "Hera will minimize your css and js scripts."
    system "jammit -o _public/assets -c _assets.yml"
    puts "Your production assets are now minimized."

  end
end
