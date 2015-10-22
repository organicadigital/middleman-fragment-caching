
# Middleman Fragment Caching

A Middleman fragment caching extension like Rails.

## Purpose

When we need build many pages, fragment caching can decrease the build time.

## Installation

Add this line on Gemfile:

```ruby
gem 'middleman-fragment-caching', '~> 0.0.1'
```

Run bundler:

```
$ bundle
```

## Usage

Activate the extension, adding the folling code on `config.rb`

```ruby
activate :middleman_fragment_caching
```

On your app views:

```ruby
<% fragment_cache('my_key') do %>
  ... some expensive content
<% end %>

<% fragment_cache('my_key', 'some_version', 123) do %>
  ... other expensive content
<% end %>
```

Clear all cache:

```
$ rm -r tmp/cache
```



