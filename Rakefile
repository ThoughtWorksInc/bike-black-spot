require "sinatra/activerecord/rake"

desc 'Build the application'
task :build do
  puts('------------ Bundling the reqs -------------')
  system('bundle install')
end

desc 'Run the server'
task :run do
  puts('------------ Running the server ------------')
  system('rackup')
end

namespace :db do
	desc "load db configuration"
	task :load_config do
		require "./app.rb"
  end

  desc 'setup db stuff for local tests'
  task :init do
    sh('bundle exec rake db:create db:migrate RACK_ENV=test')
  end
end

desc 'Run RSpec tests'
task :test do
  # system('export RACK_ENV=test')
  raise 'failed' unless system('rspec test --color')
end

desc 'I am lazy'
task :t => [:test]

desc 'Build then run'
task :exec => [:build,:test,:run]

#Default
task :default => [:exec]
