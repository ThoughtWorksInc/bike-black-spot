#Source List
source 'https://rubygems.org'
ruby '2.1.3'
gem 'bundler', '1.10.5'
gem 'rake'
gem 'sinatra'
gem 'rack-throttle'

#Auth
gem 'warden'
gem 'bcrypt'

#DB
gem 'sinatra-activerecord'
gem 'bson'
gem 'pg'

#Email
gem 'mail'

group :development do
  gem 'tux'
end

group :development, :test do
  gem 'rspec', :require => 'test'
  gem 'rack-test'
  gem 'bundler-audit'
  gem 'rubocop'
  gem 'sqlite3'
  gem 'database_cleaner'
end