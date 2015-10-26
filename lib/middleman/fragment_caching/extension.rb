module Middleman
  module FragmentCaching
    class Extension < ::Middleman::Extension

      def after_build(_)
        Cache.instance.clear!
      end

      def before_build(_)
        FileUtils.rm_rf('tmp/cache')
      end

      helpers do
        def fragment_cache(*keys, &block)
          content = Cache.instance.find_or_set(keys.join('_')) do
            capture_html(&block)
          end

          concat_content content
        end
      end
    end
  end
end
