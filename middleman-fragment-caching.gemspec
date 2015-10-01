# -*- encoding: utf-8 -*-
$LOAD_PATH.push File.expand_path('../lib', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'middleman-fragment-caching'
  s.version     = '0.0.1'
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Orgânica Digital']
  s.email       = %w(alessandro@organicadigital.com)
  s.homepage    = 'http://organicadigital.com'
  s.summary     = 'A Middleman fragment caching extension like Rails'
  s.description = s.summary
  s.license     = 'MIT'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }

  s.add_runtime_dependency 'middleman-core', '>= 3.3.0'
  s.add_runtime_dependency 'moneta', '~> 0.7.20'

  s.add_development_dependency 'rspec', '>= 3.3.0'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'pry-meta'
end
