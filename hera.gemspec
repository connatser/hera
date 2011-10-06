$:.push File.expand_path("../lib", __FILE__)
require "hera/version"

Gem::Specification.new do |s|
  s.name = 'hera'
  s.date = '2011-10-06'
  s.version = Hera::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = ['Brian Connatser']
  s.email = 'connatser@gmail.com'
  s.homepage = 'http://github.com/connatser/hera'
  s.summary = %q{Hera}
  s.description = %q{Hera, an elegant and easy to use static web site architecture.}

  s.add_development_dependency("rspec", "~>2.5.0")

  s.add_runtime_dependency("github", "~> 0.6.2")
  s.add_runtime_dependency("growl", "~> 1.0.3")
  s.add_runtime_dependency("growl_notify", "~> 0.0.1")
  s.add_runtime_dependency("guard", "~> 0.7.0")
  s.add_runtime_dependency("guard-rake", "~> 0.0.1")
  s.add_runtime_dependency("haml", "~> 3.1.3")
  s.add_runtime_dependency("jammit", "~> 0.6.3")
  s.add_runtime_dependency("jekyll", "~> 0.11.0")
  s.add_runtime_dependency("rb-fsevent", "~> 0.4.3.1")
  s.add_runtime_dependency("sass", "~> 3.1.7")

  s.executables = ['hera']
  s.require_paths = %w[lib]

  s.files = %w[
      lib/hera.rb
      lib/hera/base.rb
      lib/hera/version.rb
      lib/hera/deploy_hera.rb
      lib/hera/generate_hera.rb
      lib/hera/init_hera.rb
      lib/hera/watch_hera.rb
      lib/hera/minimize_hera.rb
      Gemfile
    ]
end
