# frozen_string_literal: true

module RailsAssetslessContainer
  module SprocketsExt
    def compile(*_args)
      super.tap do
        RailsAssetslessContainer.after_sprockets(@filename.to_s)
      end
    end
  end

  Sprockets::Manifest.prepend(SprocketsExt)
end
