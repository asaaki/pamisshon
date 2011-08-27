# encoding: utf-8

module Pamisshon  

  # redis namespace with pamisshon defaults
  class Connection < ::Redis::Namespace
    def initialize(namespace=nil, options = {})
      ns = namespace ? namespace : :pamisshon
      
      unless options[:force_ns]
        %w|RAILS_ENV PADRINO_ENV PAMISSHON_ENV|.each do |env|
          ns = :"#{namespace||:pamisshon}_#{::ENV[env]}" unless (::ENV[env].nil?)
        end
      end
      
      options = options[:redis] ? { :redis => options[:redis] } : { :redis => ::Redis.new(:db=>15) }
      super(ns, options)
    end
    
    def flush_keys
      self.keys.each do |k|
        self.del k
      end
      return true if self.keys.count==0
      false
    end
    
  end

end

