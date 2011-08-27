# encoding: utf-8

require "redis"
require "redis/namespace"
require "active_support/concern"

require "pamisshon/connection"
require "pamisshon/permission"

module Pamisshon
  VERSION     = File.read(File.dirname(__FILE__) + '/../VERSION') rescue "no VERSION file present"
  GEM_VERSION = Gem::Version.new(VERSION)
  ENV         = ENV['PAMISSHON_ENV']
end

require "pamisshon/dev_helper" if Pamisshon::ENV=="development"

