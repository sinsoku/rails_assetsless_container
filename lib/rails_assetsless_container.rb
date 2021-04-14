# frozen_string_literal: true

require "sprockets"
begin
  require "webpacker"
rescue LoadError
  # do nothing
end

require "active_support/core_ext/module/delegation"

module RailsAssetslessContainer
  class Error < StandardError; end

  class << self
    def after_sprockets(path)
      strategy.after_sprockets(path) if enabled?
    end

    def after_webpacker(path)
      strategy.after_webpacker(path) if enabled?
    end

    def download_manifests
      return unless enabled?

      download_sprockets_manifest
      download_webpacker_manifest if defined?(Webpacker)
    end

    delegate :enabled?, :strategy, to: :config

    private

    def download_sprockets_manifest
      dirname = Rails.root.join("public/assets")
      path = Sprockets::ManifestUtils.find_directory_manifest(dirname)
      strategy.write_sprockets_manifest(path)
    end

    def download_webpacker_manifest
      path = Webpacker.config.public_manifest_path.to_s
      strategy.write_webpacker_manifest(path)
    end
  end
end

require_relative "rails_assetsless_container/sprockets_ext"
require_relative "rails_assetsless_container/webpacker_ext" if defined?(Webpacker)
require_relative "rails_assetsless_container/railtie" if defined?(Rails)

require_relative "rails_assetsless_container/config"
require_relative "rails_assetsless_container/version"
require_relative "rails_assetsless_container/strategy/base"
require_relative "rails_assetsless_container/strategy/asset_server"
require_relative "rails_assetsless_container/strategy/log"
