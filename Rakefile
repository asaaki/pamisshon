# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "pamisshon"
  gem.homepage = "http://github.com/asaaki/pamisshon"
  gem.license = "MIT"
  gem.summary = %Q{pāmisshon (パーミッション) | permission handling with redis}
  gem.description = %Q{pāmisshon (パーミッション) is a gem for easy permission handling in apps.}
  gem.email = "chris@dinarrr.com"
  gem.authors = ["Christoph Grabo"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

#--- Pamisshon specific tasks

task :environment do
  ENV['PAMISSHON_ENV'] ||= 'development' unless ENV['RAILS_ENV'] || ENV['PADRINO_ENV']
end

desc "Open an irb session preloaded with this library"
task :irb => :environment do
  sh "bundle exec irb -I lib -r pamisshon.rb"
end

#--- default

task :default => [:environment, :spec]

