# frozen_string_literal: true

module RailsAssetslessContainer
  module WebpackerExt
    def compile
      super.tap do
        RailsAssetslessContainer.after_webpacker(config.public_manifest_path.to_s)
      end
    end
  end

  Webpacker::Compiler.prepend(WebpackerExt)
end
