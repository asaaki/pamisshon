# encoding: utf-8

module Pamisshon
  module Helper
    extend ActiveSupport::Concern
    
    module ClassMethods
    end
    
    module InstanceMethods
        
      def cast(thing)
        thing_class,thing_id = nil
        
        if thing.respond_to?(:ancestors)
          if thing.respond_to?(:superclass)
            thing_class = thing.to_s.downcase
            thing_id = Pamisshon::Configuration.config.everything
          else
            raise Pamisshon::Errors::WrongType,
              "Thing is a #{subject.class}, but only classes allowed here."
          end
        else
          thing_class = thing.class.to_s.downcase
          thing_id ||= thing.try(Pamisshon::Configuration.config.identifier)
          if thing_id == Pamisshon::Configuration.config.everything
            raise Pamisshon::Errors::ReservedKeyword,
              "You have an inappropriate id which is reserved (#{Pamisshon::Configuration.config.everything})."
          elsif thing_id.nil?
            raise Pamisshon::Errors::MissingId,
              "Thing has no Pamisshon::Configuration.config.identifier."
          end
        end
        ary_to_key [thing_class,thing_id]
      end
      
      def uncast_by_method(klass,id,by_method)
        obj = nil
        if id==Pamisshon::Configuration.config.everything
          obj = klass.capitalize.constantize
        else
          obj = klass.capitalize.constantize.try(by_method, id)
        end
        if obj.nil?
          raise Pamisshon::Errors::NotFound,
            "Could not retrieve the requested object `#{klass.capitalize.constantize}' with `#{id}' by `#{by_method}'."
        end
        obj
      end
      
      def uncast(klass,id)
        uncast_by_method(klass,id,Pamisshon::Configuration.config.finder)
      end
      
      def key_to_ary(k)
        k.split(Pamisshon::Configuration.config.delimiter)
      end
      
      def ary_to_key(a)
        a.join(Pamisshon::Configuration.config.delimiter)
      end
      
    end
    
  end
end

