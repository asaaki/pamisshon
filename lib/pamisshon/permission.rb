# encoding: utf-8

module Pamisshon
  class Permission
    include Pamisshon::Helper
      
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
      perm = @conn.get ary_to_key([cast(subject),verb,cast(object)])
      return true if perm.to_i==1
      false
    end
    
    def get_perms_for(subject)
      # keys subject_klass/subject_id
      # keys subject_klass/__ALL__
    end
    
    def get_perms_for_and_with(subject,verb)
      # keys subject_klass/subject_id/verb
      # keys subject_klass/__ALL__/verb
    end
    
    def retrieve(key,value)
      s_class,s_id,verb,o_class,o_id = key_to_ary(key)
      
      subject = uncast(s_class,s_id)
      object = uncast(o_class,o_id)
      
      perm = nil
      perm = true if value.to_i==1
      perm = false if value.to_i==0
      
      [subject,verb.to_sym,object,perm]
    end
    
    private
    
    def invoke(subject,verb,object,allowed=nil)
      raise Pamisshon::Errors::MissingPermissionLevel, "Only true or false allowed here." if allowed.nil?
      [ary_to_key([cast(subject),verb,cast(object)]),"#{allowed ? '1':'0' }"]
    end
    
  
  end
end

