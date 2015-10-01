require 'moneta'

module Moneta
  # Add Moneta keys list support
  class Proxy
    def keys
      adapter.keys
    end
  end

  module Adapters
    class File
      def keys
        Dir.entries(@dir).reject do |e|
          %w(. .. .DS_Store).include?(e)
        end
      end
    end
  end
end
