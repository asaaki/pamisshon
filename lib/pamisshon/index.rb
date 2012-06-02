# encoding: utf-8

module Pamisshon
  module Index
    extend ActiveSupport::Concern

    module ClassMethods
    end

    module InstanceMethods

      INDICES = {
        :subjects => "%s/*/*/*/*",
        :verbs    => "*/*/%s/*/*",
        :objects  => "*/*/*/%s/*"
      }
      INDEX_PREFIX = "index:"

#      def initialize
#        raise "No connection available!" if @conn.nil?
#        INDICES.keys.each do |key|
#          @conn.hset (INDEX_PREFIX+key), "nil", "nil"
#        end
#      end

      def get_all_indices
        result = {}
        result = @conn.multi do
          INDICES.keys.each do |key|
            get_index(key)
          end
        end
        Hash[*INDICES.keys.zip(result).flatten(1)]
      end

      def get_index(index)
        @conn.smembers INDEX_PREFIX+index.to_s
      end

      def add_to_index(index,thing)
        @conn.sadd INDEX_PREFIX+index.to_s, thing
      end

      def delete_from_index(index,thing)
        @conn.srem INDEX_PREFIX+index.to_s, thing
      end

    end

  end
end
