source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.4'
gem 'pg', '~> 0.21.0'
gem 'puma', '~> 3.7'
gem 'jbuilder', '~> 2.5'
gem 'rack-cors'
gem 'rails-ujs'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
  gem 'rspec-rails'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'omniauth'
gem 'devise_token_auth'
gem 'acts-as-taggable-on', '~> 5.0'
gem 'dry-validation', '~> 0.11.1'
gem 'wisper', '2.0.0'
gem 'turbolinks'
gem 'uglifier'

gem 'sidekiq'
gem 'sidekiq-cron'
gem 'redis'
gem 'figaro'
gem 'rufus-scheduler', '~> 3.4.0'

ruby "2.4.2"