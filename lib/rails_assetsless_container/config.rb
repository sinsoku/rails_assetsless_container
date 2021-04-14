# frozen_string_literal: true

module RailsAssetslessContainer
  class << self
    def config
      @config ||= Config.new
    end

    def configure
      yield config
    end
  end

  class Config
    attr_accessor :enabled, :strategy
    alias enabled? enabled

    def initialize
      @enabled = false
      @strategy ||= Strategy::AssetServer.new
    end
  end
end
