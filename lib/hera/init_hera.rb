#!/usr/bin/env ruby

require 'rubygems'
require 'github'

class InitHera
  def initialize (options = {:site_type => ''})

    $site_type = options[:site_type]

    if ($site_type == "site" || $site_type == nil)
      clone_base_site
    end

    if ($site_type == "app")
      clone_app_site
    end

    if ($site_type == "product")
      clone_product_site
    end
  end

  def clone_base_site
    puts "Hera will now install: Base site, by HydraulicLabs."
    system "gh clone connatser/hera_site ."
    check_for_config
  end

  def clone_app_site
    puts "Application site theme coming soon."
  end

  def clone_product_site
    puts "Product site theme coming soon."
  end

  def check_for_config
    system "hera"
  end
end
