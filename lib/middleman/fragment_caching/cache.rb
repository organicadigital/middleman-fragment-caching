require 'singleton'
require 'set'
require 'moneta'

module Middleman
  module FragmentCaching
    # Cache management
    class Cache
      class << self
        def dir
          @dir ||= File.expand_path('tmp/cache').tap do |path|
            FileUtils.mkdir_p(path)
          end
        end

        def store
          @store ||= create_store(:File, dir: dir)
        end

        # Creates a store
        # @return [Moneta] store instance
        def create_store(kind, options = {})
          Moneta.new(kind, options)
        end
      end

      include Singleton

      def store
        self.class.store
      end

      def stored_keys
        @stored_keys ||= Set.new
      end

      def find_or_set(key, &block)
        key = key.to_s

        if !key.empty? && store.key?(key)
          content = store[key]
        else
          content = block.call
          store[key] = content unless key.empty?
        end

        stored_keys << key unless key.empty?

        content
      end

      def expires_keys
        store.keys - stored_keys.to_a
      end

      def clear!
        expires_keys.each do |key|
          store.delete key
        end

        stored_keys.clear
      end
    end
  end
end
