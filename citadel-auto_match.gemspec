$:.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'citadel/auto_match/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'citadel-auto_match'
  s.version     = Citadel::AutoMatch::VERSION
  s.authors     = ['Benjamin Schaaf']
  s.email       = ['ben.schaaf@gmail.com']
  # s.homepage    = 'TODO'
  s.summary     = 'Automatic match submission system for citadel.'
  s.description = 'Automatic match submission system for citadel.'
  s.license     = 'MIT'

  s.files = Dir["{app,config,db,lib}/**/*", 'LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'rails', '~> 5.2.1'
  s.add_development_dependency 'open_api_annotator'
end
