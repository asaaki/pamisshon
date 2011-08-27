# encoding: utf-8

module Pamisshon
  module Configuration
  
    class Config
      private_class_method :new
      def self.instance
        @__instance__ ||= new
      end
      
      attr_reader :identifier, :delimiter, :finder, :everything
      
      def initialize
        @identifier = :id
        @delimiter  = "/"
        @finder     = :find
        @everything = "##ALL##"
      end
      
      def identified_by(v)
        @identifier=v
      end
      
      def delimited_by(v)
        @delimiter=v
      end
      
      def finder_method(v)
        @finder=v
      end
      
      def everything_key(v)
        @everything=v
      end
      
    end
    
    def self.configure
      if block_given?
        yield Config.instance
      else
        Config.instance
      end
    end
    
    def self.config
      Config.instance
    end

  end
end

