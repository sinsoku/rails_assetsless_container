# frozen_string_literal: true

RSpec.describe RailsAssetslessContainer::Strategy::Base do
  let(:klass) { Class.new(described_class) }
  let(:strategy) { klass.new }

  describe "#after_sprockets" do
    it do
      msg = "Subclass must implement this method to save the manifest from `path`."
      expect { strategy.after_sprockets(nil) }.to raise_error(NotImplementedError, msg)
    end
  end

  describe "#after_webpacker" do
    it do
      msg = "Subclass must implement this method to save the manifest from `path`."
      expect { strategy.after_webpacker(nil) }.to raise_error(NotImplementedError, msg)
    end
  end

  describe "#write_sprockets_manifest" do
    it do
      msg = "Subclass must implement this method to write the manifest to `path`."
      expect { strategy.write_sprockets_manifest(nil) }.to raise_error(NotImplementedError, msg)
    end
  end

  describe "#write_webpacker_manifest" do
    it do
      msg = "Subclass must implement this method to write the manifest to `path`."
      expect { strategy.write_webpacker_manifest(nil) }.to raise_error(NotImplementedError, msg)
    end
  end
end
