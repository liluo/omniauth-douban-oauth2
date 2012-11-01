# encoding: utf-8

require File.expand_path('../lib/omniauth-douban/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['Liluo']
  gem.email         = ['i@liluo.org']
  gem.description   = %q{OmniAuth OAuth2 strategy for Douban.}
  gem.summary       = %q{OmniAuth OAuth2 strategy for Douban.}
  gem.homepage      = 'https://github.com/liluo/omniauth-douban-oauth2'

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = 'omniauth-douban-oauth2'
  gem.require_paths = ['lib']
  gem.version       = OmniAuth::Douban::VERSION

  gem.add_dependency 'omniauth', '~> 1.0'
  gem.add_dependency 'omniauth-oauth2', '~> 1.0.2'
end
