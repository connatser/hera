Gem::Specification.new do |s|
  s.name        = 'hera'
  s.version     = '0.0.0'
  s.date        = '2011-09-27'
  s.summary     = "Hera"
  s.description = "Hera, a rapid website prototyping tool."
  s.authors     = ["Brian Connatser"]
  s.email       = 'connatser@gmail.com'
  s.homepage    = 'http://github.com/connatser/hera'
  s.executables = ["hera"]
  s.require_paths = %w[lib]
  s.files = %w[
      lib/hera.rb
      lib/init_hera.rb
      lib/install_hera.rb
      lib/watch_hera.rb
      lib/generate_hera.rb
      lib/deploy_hera.rb
      Gemfile
    ]
end