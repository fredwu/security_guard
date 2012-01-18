# -*- encoding: utf-8 -*-
require File.expand_path('../lib/security_guard/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['Fred Wu']
  gem.email         = ['fred.wu@sitepoint.com']
  gem.summary       = %q{A bunch of helpers for security audit.}
  gem.description   = gem.summary
  gem.homepage      = 'http://sitepoint.com/'

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = 'security_guard'
  gem.require_paths = ['lib']
  gem.version       = SecurityGuard::VERSION

  gem.add_dependency 'geoip'
  gem.add_development_dependency 'simplecov'
end