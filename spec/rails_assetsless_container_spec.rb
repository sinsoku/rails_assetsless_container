# frozen_string_literal: true

RSpec.describe RailsAssetslessContainer do
  include_context "with rails_root"

  klass = Class.new(RailsAssetslessContainer::Strategy::Base) do
    attr_reader :history

    def initialize
      @history = {}
    end

    def after_sprockets(path)
      @history[:after_sprockets] = path
    end

    def after_webpacker(path)
      @history[:after_webpacker] = path
    end

    def write_sprockets_manifest(path)
      @history[:write_sprockets_manifest] = path
    end

    def write_webpacker_manifest(path)
      @history[:write_webpacker_manifest] = path
    end
  end

  let(:strategy) { klass.new }
  let(:manifest_path) { "path/dummy.json" }

  before do
    described_class.configure do |config|
      config.strategy = strategy
    end
  end

  describe "#after_sprockets" do
    context "when disabled" do
      before do
        described_class.config.enabled = false
        described_class.after_sprockets(manifest_path)
      end

      it { expect(strategy.history).to be_empty }
    end

    context "when enabled" do
      before do
        described_class.config.enabled = true
        described_class.after_sprockets(manifest_path)
      end

      it { expect(strategy.history).to include(after_sprockets: manifest_path) }
    end
  end

  describe "#after_webpacker" do
    context "when disabled" do
      before do
        described_class.config.enabled = false
        described_class.after_webpacker(manifest_path)
      end

      it { expect(strategy.history).to be_empty }
    end

    context "when enabled" do
      before do
        described_class.config.enabled = true
        described_class.after_webpacker(manifest_path)
      end

      it { expect(strategy.history).to include(after_webpacker: manifest_path) }
    end
  end

  describe "#download_manifests" do
    context "when disabled" do
      before do
        described_class.config.enabled = false
        described_class.download_manifests
      end

      it { expect(strategy.history).to be_empty }
    end

    context "when enabled" do
      before do
        described_class.config.enabled = true
        rails_root.join("config").mkpath
        rails_root.join("config/webpacker.yml").write(<<~CONFIG)
          development:
            public_root_path: public
            public_output_path: packs
        CONFIG
        described_class.download_manifests
      end

      after { Webpacker.instance = nil }

      it do
        path = "#{rails_root}/public/assets/.sprockets-manifest-[0-9a-f]{32}.json"
        expect(strategy.history).to include(write_sprockets_manifest: a_string_matching(/#{path}/))
      end

      it do
        path = "#{rails_root}/public/packs/manifest.json"
        expect(strategy.history).to include(write_webpacker_manifest: a_string_matching(/#{path}/))
      end
    end
  end
end
