[![Gem Version](https://badge.fury.io/rb/rails_assetsless_container.svg)](https://badge.fury.io/rb/rails_assetsless_container)
[![Ruby](https://github.com/sinsoku/rails_assetsless_container/actions/workflows/main.yml/badge.svg)](https://github.com/sinsoku/rails_assetsless_container/actions/workflows/main.yml)

# RailsAssetslessContainer

If you're delivering assets via a CDN, you don't need to include assets in your container.

This gem provides a way to do that.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rails_assetsless_container'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install rails_assetsless_container

## Configuration

It is disabled by default, so specify it explicitly with `config/environments/production.rb`.

```ruby
Rails.application.configure do
  # some settings
end

RailsAssetslessContainer.configure do |config|
  config.enabled = true
end
```

## Strategy

### AssetServer (default)

Save the manifest file as `manifest-<suffix>.json` after `assets:precompile`.

Download `manifest-<suffix>.json` via CDN and save it as `manifest.json` before starting the server.

see: [lib/rails_assetsless_container/strategy/asset_server.rb](https://github.com/sinsoku/rails_assetsless_container/blob/main/lib/rails_assetsless_container/strategy/asset_server.rb)

### Log

A strategy for checking each method call for debugging.

```ruby
RailsAssetslessContainer.configure do |config|
  config.enabled = true
  logger = Logger.new(STDOUT)
  config.strategy = RailsAssetslessContainer::Strategy::Log.new(logger)
end
```

see: [lib/rails_assetsless_container/strategy/log.rb](https://github.com/sinsoku/rails_assetsless_container/blob/main/lib/rails_assetsless_container/strategy/log.rb)

### Custom

You can also use custom strategy.

```ruby
class CustomStrategy < RailsAssetslessContainer::Strategy::Base
  def after_sprockets(path)
    # To save the manifest from `path`.
  end

  def after_webpacker(path)
    # To save the manifest from `path`.
  end

  def write_sprockets_manifest(path)
    # To write the manifest to `path`.
  end

  def write_webpacker_manifest(path)
    # To write the manifest to `path`.
  end
end

RailsAssetslessContainer.configure do |config|
  config.enabled = true
  config.strategy = CustomStrategy.new
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sinsoku/rails_assetsless_container. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/sinsoku/rails_assetsless_container/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the RailsAssetslessContainer project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/sinsoku/rails_assetsless_container/blob/main/CODE_OF_CONDUCT.md).
