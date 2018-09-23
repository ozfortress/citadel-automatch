source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Declare your gem's dependencies in citadel-automatch.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# Use serializer and controller annotations to generate OpenAPI specs
# gem 'open_api_annotator'

# Include citadel's dependencies
citadel_path = ENV['CITADEL'] || '../citadel'
citadel_gemfile = "#{citadel_path}/Gemfile"
instance_eval File.read(citadel_gemfile)
