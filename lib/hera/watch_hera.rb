#!/usr/bin/env ruby

class WatchHera
  def initialize

    puts "Hera will now watch for your template changes."
    puts "CTRL+C to stop watching."
    system "guard start"

  end
end