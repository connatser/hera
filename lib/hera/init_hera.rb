#!/usr/bin/env ruby

require 'rubygems'
require 'github'

class InitHera
  def initialize

    puts "Hera will now install the initial site structure for you to work your magic."
    system "gh clone connatser/hera_site ."

  end
end