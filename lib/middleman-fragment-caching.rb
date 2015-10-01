require 'middleman-core'
require 'middleman/fragment_caching/moneta'
require 'middleman/fragment_caching/cache'

::Middleman::Extensions.register(:middleman_fragment_caching) do
  require 'middleman/fragment_caching/extension'
  ::Middleman::FragmentCaching::Extension
end
