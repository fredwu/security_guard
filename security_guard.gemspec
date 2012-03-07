# -*- encoding: utf-8 -*-
require File.expand_path('../lib/security_guard/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['Fred Wu']
  gem.email         = ['ifredwu@gmail.com']
  gem.summary       = %q{A collection of useful tools for auditing data and performing security checks.}
  gem.description   = gem.summary
  gem.homepage      = 'https://github.com/fredwu/security_guard'

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = 'security_guard'
  gem.require_paths = ['lib']
  gem.version       = SecurityGuard::VERSION

  gem.add_dependency 'clamp'
  gem.add_dependency 'awesome_print'
  gem.add_dependency 'geoip'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'simplecov'
  gem.add_development_dependency 'minitest-colorize'
end
