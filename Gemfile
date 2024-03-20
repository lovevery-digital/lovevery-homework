source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.8'

gem 'rails', '~> 6.0.0'
# Use postgres as the database for Active Record
gem 'pg'
gem 'puma', '~> 4.3'
gem 'sass-rails', '~> 6'
gem 'webpacker', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'

#added these to address vulnerabilities
gem "nokogiri", ">= 1.10.8"
gem "actionview", ">= 6.0.2.2"
gem "net-http"

# Redis Caching
gem 'redis'
gem 'hiredis'

# Boolean conversion
gem 'wannabe_bool'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'byebug'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec'
  gem 'rspec-rails'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'webdrivers'
end

gem "rspec-rails", groups: [ :development, :test ]

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
