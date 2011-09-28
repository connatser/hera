#!/usr/bin/env ruby

class DeployHera
  def initialize

    puts "Hera will now deploy your site."
    puts "Make sure that you have set ssh_user and remote_root in RakeFile"
    system "rake deploy"

  end
end