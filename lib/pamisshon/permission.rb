# encoding: utf-8

module Pamisshon  

  class Permission
  
    attr_accessor :conn
  
    def initialize(namespace=nil, options = {})
      @conn = Connection.new(namespace,options)
    end
  
  end

end

