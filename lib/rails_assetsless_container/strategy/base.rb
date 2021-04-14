# frozen_string_literal: true

module RailsAssetslessContainer
  module Strategy
    class Base
      SAVE_MSG = "Subclass must implement this method to save the manifest from `path`."
      WRITE_MSG = "Subclass must implement this method to write the manifest to `path`."
      private_constant :SAVE_MSG, :WRITE_MSG

      def after_sprockets(_path)
        raise NotImplementedError, SAVE_MSG
      end

      def after_webpacker(_path)
        raise NotImplementedError, SAVE_MSG
      end

      def write_sprockets_manifest(_path)
        raise NotImplementedError, WRITE_MSG
      end

      def write_webpacker_manifest(_path)
        raise NotImplementedError, WRITE_MSG
      end
    end
  end
end
