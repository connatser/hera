require 'yaml'

module Hera
  
  class CreateHeraConfig
    def self.check_config
      if (!File.exist? "_hera_config.yml")
        CreateHeraConfig.create_config
      else
        CreateHeraConfig.open_config
      end
    end
    
    def self.create_config
      puts "Hera did not detect a config file, so I will graciously create one for you."
      File.open( "_hera_config.yml", "w" ) do |the_file|
        the_file.puts "hera:"
        the_file.puts "  jekyll_templates:"
        the_file.puts "    src: _source/_layouts/haml/"
        the_file.puts "    prod: ../"
        the_file.puts "  pages:"
        the_file.puts "    src: _source/_layouts/pages/"
        the_file.puts "    prod: ../../"
        the_file.puts "  posts:"
        the_file.puts "    src: _source/_layouts/posts/"
        the_file.puts "    prod: ../../_posts/"
        the_file.puts "  sass:"
        the_file.puts "    src: _source/_layouts/sass/"
        the_file.puts "    prod: ../../assets/"
      end
      CreateHeraConfig.open_config
    end
    
    def self.open_config
      $hera_config = open('_hera_config.yml') {|f| YAML.load(f) }

      if (!$hera_config)
        CreateHeraConfig.create_config
      else 
        CreateHeraConfig.populate_config
      end
    end
    
    def self.populate_config
      $jekyll_src = $hera_config['hera']['jekyll_templates']['src']
      $jekyll_prod = $hera_config['hera']['jekyll_templates']['prod']

      $pages_src = $hera_config['hera']['pages']['src']
      $pages_prod = $hera_config['hera']['pages']['prod']
  
      $posts_src = $hera_config['hera']['posts']['src']
      $posts_prod = $hera_config['hera']['posts']['prod']
  
      $sass_src = $hera_config['hera']['sass']['src']
      $sass_prod = $hera_config['hera']['sass']['prod']
  
      # Base
      File.open( "Guardfile", "w" ) do |the_file| 
        the_file.puts "guard 'rake', :task => 'parse_haml' do"
        the_file.puts "  watch(%r{" + $jekyll_src + "})"
        the_file.puts "end" 

        the_file.puts ""
        the_file.puts "guard 'rake', :task => 'parse_haml_pages' do"
        the_file.puts "  watch(%r{" + $pages_src + "})"
        the_file.puts "end"

        the_file.puts ""
        the_file.puts "guard 'rake', :task => 'parse_haml_posts' do"
        the_file.puts "  watch(%r{" + $posts_src + "})"
        the_file.puts "end"

        the_file.puts ""
        the_file.puts "guard 'rake', :task => 'parse_sass' do"
        the_file.puts "  watch(%r{" + $sass_src + "})"
        the_file.puts "end"
      end

      # Base
      File.open( "RakeFile", "w" ) do |the_file| 
        the_file.puts "#rsync deployment parameters"
        the_file.puts "ssh_user = 'user@domain.com'"
        the_file.puts "remote_root = '~/path/to/remote/'"
    
        the_file.puts ""
        the_file.puts "task :parse_templates => [:parse_haml] do"
        the_file.puts "  puts 'Haml and Sass have been parsified...'"
        the_file.puts "end"
    
        the_file.puts ""
        the_file.puts "task :parse_haml => [:parse_haml_pages] do"
        the_file.puts "  system(%{"
        the_file.puts "    cd _source/_layouts/haml && for f in *.haml;"
        the_file.puts "    do [ -e $f ] && haml $f " + $jekyll_prod + "${f%.haml}.html; done"
        the_file.puts "  })"
        the_file.puts "end"

        the_file.puts ""
        the_file.puts "task :parse_haml_pages => [:parse_haml_posts] do"
        the_file.puts "  system(%{"
        the_file.puts "    cd _source/_layouts/pages && for f in *.haml;"
        the_file.puts "    do [ -e $f ] && haml $f " + $pages_prod + "${f%.haml}.html; done"
        the_file.puts "  })"
        the_file.puts "end"

        the_file.puts ""
        the_file.puts "task :parse_haml_posts => [:parse_sass] do"
        the_file.puts "  system(%{"
        the_file.puts "    cd _source/_layouts/posts && for f in *.haml;"
  	    the_file.puts "    do [ -e $f ] && haml $f " + $posts_prod + "${f%.haml}.html; done"
        the_file.puts "  })"
        the_file.puts "end"
    
        the_file.puts ""
        the_file.puts "task :parse_sass do"
        the_file.puts "  system(%{"
        the_file.puts "    cd _source/_layouts/sass && for f in *.scss;"
        the_file.puts "    do [ -e $f ] && sass $f " + $sass_prod + "${f%.scss}.css; done"
        the_file.puts "  })"
        the_file.puts "end"
    
        the_file.puts ""
        the_file.puts "task :deploy do"
        the_file.puts "  system('rsync -avz --delete _public/ \#{ssh_user}:\#{remote_root}')"
        the_file.puts "end"
      end
    end
  end
  
  if !Dir["*"].empty?
    CreateHeraConfig.check_config
  end
  
=begin
  puts $jekyll_src
  puts $jekyll_prod
  puts $posts_src
  puts $posts_prod
  puts $pages_src
  puts $pages_prod
=end
   
end