source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.4'
gem 'aws-sdk-s3', require: false
gem 'rails', '~> 6.1.3'
gem 'pg', '~> 1.5', '>= 1.5.5'
gem 'puma', '~> 5.0'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
gem 'redis', '~> 4.0'
# gem 'bcrypt', '~> 3.1.7'
gem 'slim-rails', '~> 3.1', '>= 3.1.1'
gem 'devise', '~> 4.8', '>= 4.8.1'
gem "cocoon"
gem 'validate_url'
gem 'cancancan'
gem 'sidekiq'
gem 'sinatra', require: false
gem 'whenever', require: false
gem 'mysql2',          '~> 0.5.3', :platform => :ruby
gem 'thinking-sphinx', '~> 5.5.1', :require => 'thinking_sphinx/sinatra'
gem 'jdbc-mysql',      '~> 5.1.35', :platform => :jruby
gem 'database_cleaner-active_record'

gem 'jquery-rails', '~> 4.4'
gem 'gon', '~> 6.2'
gem 'skim', '~> 0.11'
gem 'omniauth'
gem 'omniauth-github'
gem 'omniauth-vkontakte'
gem 'omniauth-rails_csrf_protection'
gem 'doorkeeper'
gem 'active_model_serializers', '~> 0.10'
gem 'oj'
gem 'bcrypt_pbkdf', '~> 1.0'
gem 'ed25519','~> 1.2'
gem "mini_racer"
gem "unicorn"

# gem 'image_processing', '~> 1.2'

gem 'bootsnap', '>= 1.4.4', require: false

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 5.1', '>= 5.1.2'
  gem 'factory_bot_rails'
  gem 'letter_opener'
end

group :development do
  gem 'web-console', '>= 4.1.0'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  gem 'spring'
  gem 'rubocop', '~> 1.29', require: false
  gem 'rubocop-rails', '~> 2.14', require: false
  gem 'rubocop-rspec', '~> 2.10', require: false
  gem 'rubocop-performance', '~> 1.13', require: false

  gem 'capistrano', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rails', require: false
  gem 'capistrano-rvm', require: false
  gem 'capistrano-passenger', require: false
  gem 'capistrano-sidekiq', require: false
  gem 'capistrano-yarn', require: false
  gem 'capistrano3-unicorn', require: false
end

group :test do
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'
  gem 'webdrivers', "= 5.3.0"
  gem 'shoulda-matchers', '~> 5.0'
  gem 'rails-controller-testing'
  gem 'launchy'
  gem 'capybara-email'
end

# gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]