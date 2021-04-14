# frozen_string_literal: true

require "rails/railtie"

module RailsAssetslessContainer
  class Railtie < ::Rails::Railtie
    if defined?(Rails::Server) || defined?(Unicorn::Launcher)
      config.before_initialize do
        RailsAssetslessContainer.download_manifests
      end
    end
  end
end
