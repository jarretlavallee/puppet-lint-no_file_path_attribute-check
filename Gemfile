# frozen_string_literal: true

source 'https://rubygems.org'

gemspec

group :test do
  gem 'json'
  gem 'rake', '>= 12.3.3'
  gem 'rspec', '>= 3.0'
  gem 'rspec-collection_matchers', '>= 1.0'
  gem 'rspec-its', '>= 1.0'
  gem 'rubocop'
  gem 'rubocop-rspec'
  gem 'rubocop-rake'
  gem 'simplecov', require: false
end

group :development do
  gem 'github_changelog_generator', require: false if RUBY_VERSION >= '2.2.2'
end
