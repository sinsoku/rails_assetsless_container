# frozen_string_literal: true

module RailsAssetslessContainer
  module Strategy
    class Log < Base
      attr_reader :logger

      def initialize(logger)
        @logger = logger
      end

      def after_sprockets(path)
        logger.info("after_sprockets: #{path}")
      end

      def after_webpacker(path)
        logger.info("after_webpacker: #{path}")
      end

      def write_sprockets_manifest(path)
        logger.info("write_sprockets_manifest: #{path}")
      end

      def write_webpacker_manifest(path)
        logger.info("write_webpacker_manifest: #{path}")
      end
    end
  end
end
