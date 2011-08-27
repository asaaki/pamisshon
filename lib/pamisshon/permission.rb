# encoding: utf-8

module Pamisshon  

  class Permission
  
    IDENTIFIER = :id
    FINDER_METHOD = :find
    DELIMITER = "/"
    ALL_KEYWORD = "__ALL__"
  
    attr_accessor :conn
  
    def initialize(namespace=nil, options = {})
      @conn = Connection.new(namespace,options)
    end
    
    def allow(subject,verb,object)
      k,v = invoke(subject,verb,object,true)
      @conn.set k,v
      [k,v]
    end
    
    def deny(subject,verb,object)
      k,v = invoke(subject,verb,object,false)
      @conn.set k,v
      [k,v]
    end
    
    def get_perm(subject,verb,object)
      perm = @conn.get [cast_thing(subject),verb,cast_thing(object)].join(DELIMITER)
      return true if perm.to_i==1
      false
    end
    
    def retrieve(key,value)
      s_class,s_id,verb,o_class,o_id = key.split(DELIMITER)
      subject = uncast_thing(s_class,s_id)
      object = uncast_thing(o_class,o_id)
      
      perm = nil
      perm = true if value.to_i==1
      perm = false if value.to_i==0
      [subject,verb.to_sym,object,perm]
    end
    
    private
    
    def invoke(subject,verb,object,allowed=nil)
      raise Pamisshon::Errors::MissingPermissionLevel, "Only true or false allowed here." if allowed.nil?
      [[cast_thing(subject),verb,cast_thing(object)].join(DELIMITER),"#{allowed ? '1':'0' }"]
    end
    
    def cast_thing(thing)
      thing_class,thing_id = nil
      
      if thing.respond_to?(:ancestors)
        if thing.respond_to?(:superclass)
          thing_class = thing.to_s.downcase
          thing_id = ALL_KEYWORD
        else
          raise Pamisshon::Errors::WrongType, "Thing is a #{subject.class}, but only classes allowed here."
        end
      else
        thing_class = thing.class.to_s.downcase
        thing_id ||= thing.try(IDENTIFIER)
        raise Pamisshon::Errors::MissingId, "Thing has no identifier." if thing_id.nil?
      end
      [thing_class,thing_id].join(DELIMITER)          
    end
    
    def uncast_thing_by_method(klass,id,by_method)
      obj = nil
      if id==ALL_KEYWORD
        obj = klass.capitalize.constantize
      else
        obj = klass.capitalize.constantize.try(by_method, id)
      end
      if obj.nil?
        raise Pamisshon::Errors::NotFound, "Could not retrieve the requested object `#{klass.capitalize.constantize}' with `#{id}' by `#{by_method}'."
      end
      obj
    end
    
    def uncast_thing(klass,id)
      uncast_thing_by_method(klass,id,FINDER_METHOD)
    end
  
  end

end

