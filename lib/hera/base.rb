require 'yaml'

module Hera
  
  class CreateHeraConfig
    def self.check_config
      if (!File.exist? "_deploy_config.yml")
        CreateHeraConfig.create_deploy
      else
        CreateHeraConfig.open_deploy
      end
      
      if (!File.exist? "_hera_config.yml")
        CreateHeraConfig.create_config
      else
        CreateHeraConfig.open_config
      end
    end
    
    def self.create_deploy
      #In case a config isn't present this will generate the base _hera_config.yml.
      puts "Generating _deploy_config.yml, please add your ssh information before deploying."
      File.open( "_deploy_config.yml", "w" ) do |the_file|        
        the_file.puts "ssh_user: user@domain.net"
        the_file.puts "remote_root: ~/path/to/remote/"
      end
      CreateHeraConfig.open_deploy
    end
    
    def self.create_config
      #In case a config isn't present this will generate the base _hera_config.yml.
      puts "Generating _hera_config.yml, which you can customize to your needs."
      File.open( "_hera_config.yml", "w" ) do |the_file|        
        the_file.puts "jekyll:"
        the_file.puts "  id: haml_jekyll"
        the_file.puts "  type: haml"
        the_file.puts "  ext: haml"
        the_file.puts "  src: _source/_layouts/haml/"
        the_file.puts "  prod: ../"
        the_file.puts "pages:"
        the_file.puts "  id: haml_pages"
        the_file.puts "  type: haml"
        the_file.puts "  ext: haml"
        the_file.puts "  src: _source/_layouts/pages/"
        the_file.puts "  prod: ../../"
        the_file.puts "posts:"
        the_file.puts "  id: haml_posts"
        the_file.puts "  type: haml"
        the_file.puts "  ext: haml"
        the_file.puts "  src: _source/_layouts/posts/"
        the_file.puts "  prod: ../../_posts/"
        the_file.puts "sass:"
        the_file.puts "  id: sass_style"
        the_file.puts "  type: sass"
        the_file.puts "  ext: scss"
        the_file.puts "  src: _source/_layouts/sass/"
        the_file.puts "  prod: ../../assets/"
      end
      CreateHeraConfig.open_config
    end
    
    def self.open_deploy
      $deploy_config = open('_deploy_config.yml') {|f| YAML.load(f) }
      
      if (!$deploy_config)
        CreateHeraConfig.create_deploy
      else 
        $ssh_user = $deploy_config['ssh_user']
        $remote_root = $deploy_config['remote_root']
      end
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
 
      # Generate Guardfile based on _hera_config.yml
      File.open( "Guardfile", "w" ) do |the_file| 
         $hera_config.each_key { |key|
            node = $hera_config[key]
              the_file.puts "guard 'rake', :task => '" + node['id'] + "' do"
              the_file.puts "  watch(%r{" + node['src'] + "})"              
              the_file.puts "end" 
              the_file.puts ""
          }
      end
 
      # Generate Rakefile based on _hera_config.yml
      File.open( "RakeFile", "w" ) do |the_file| 
        the_file.puts "#rsync deployment parameters"
        the_file.puts "ssh_user = '" + $ssh_user + "'"
        the_file.puts "remote_root = '" + $remote_root +"'"
        the_file.puts ""
        the_file.puts "task :deploy do"
        the_file.puts "  system('rsync -avz --delete _public/ \#{ssh_user}:\#{remote_root}')"
        the_file.puts "end"
        
        $hera_config.each_key { |key|
          node = $hera_config[key]
          
            if node['type'] == 'haml'
                $ext_type = 'html'
            end
            
            if node['type'] == 'sass'
                $ext_type = 'css'            
            end   
            
            the_file.puts ""
            the_file.puts "task :" + node['id'] + " do"
            the_file.puts "  system(%{"
            the_file.puts "    cd " + node['src'] + " && for f in *." + node['ext'] + ";"
            the_file.puts "    do [ -e $f ] && " + node['type'] + " $f " + node['prod'] + "${f%." + node['ext'] +"}." + $ext_type +"; done"
            the_file.puts "  })"
            the_file.puts "end"
        }  
      end 
    end
  end
  
  if !Dir["*"].empty?
    CreateHeraConfig.check_config
  end
   
end
