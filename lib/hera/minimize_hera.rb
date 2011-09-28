#!/usr/bin/env ruby

class MinimizeHera
  def initialize

    puts "Hera will minimize your css and js scripts."
    system "jammit -o _public/css -c _css_jammit.yml"
    system "jammit -o _public/js -c _js_jammit.yml"
    puts "Your production assets are now minimized."

  end
end