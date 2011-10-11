#!/usr/bin/env ruby

class GenerateHera
  def initialize

    puts "Please browse to http://localhost:4000 to view your site."
    puts "CTRL+C to stop preview."
    system "jekyll --server"

  end
end
