#!/usr/bin/env ruby

require 'rubygems'
require 'github'

class InitHera
  def initialize

    puts "Hera will now install the initial site structure and autogen the configs."
    system "gh clone connatser/hera_site ."
    system "hera"
  
  end
end