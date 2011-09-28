#!/usr/bin/env ruby

require 'rubygems'
require 'github'

class InitHera
  def initialize
    system "gh clone connatser/hera_site ."
  end
end