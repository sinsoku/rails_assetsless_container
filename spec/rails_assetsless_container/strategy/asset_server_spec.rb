# frozen_string_literal: true

RSpec.describe RailsAssetslessContainer::Strategy::AssetServer do
  include_context "with rails_root"

  let(:strategy) { described_class.new(asset_host: "example.com", suffix: "dummy", retry_wait: 0) }

  describe "#write_sprockets_manifest" do
    let(:path) { rails_root.join(".sprockets-dummy.json") }
    let(:manifest) do
      { files: {}, assets: {} }.to_json
    end
    let!(:stub_req) do
      stub_request(:get, "https://example.com/assets/.sprockets-manifest-dummy.json")
        .to_return(body: manifest)
    end

    before { strategy.write_sprockets_manifest(path.to_s) }

    it "gets the manifest from cdn_host and save it to path" do
      expect(stub_req).to have_been_requested
      expect(path.read).to eq manifest
    end
  end

  describe "#write_webpacker_manifest" do
    let(:path) { rails_root.join(".manifest-dummy.json") }
    let(:manifest) do
      { entrypoints: {} }.to_json
    end
    let!(:stub_req) do
      stub_request(:get, "https://example.com/packs/manifest-dummy.json")
        .to_return(body: manifest)
    end

    before { strategy.write_webpacker_manifest(path.to_s) }

    it "gets the manifest from cdn_host and save it to path" do
      expect(stub_req).to have_been_requested
      expect(path.read).to eq manifest
    end
  end

  describe "#download_with_retry" do
    let(:path) { rails_root.join(".sprockets-dummy.json") }
    let(:manifest) do
      { files: {}, assets: {} }.to_json
    end

    before do
      stub_request(:get, "https://example.com/assets/.sprockets-manifest-dummy.json")
        .to_return(status: 404).then
        .to_return(body: manifest)
      strategy.write_sprockets_manifest(path.to_s)
    end

    it "retrys getting the manifest from cdn_host and save it to path" do
      expect(path.read).to eq manifest
    end
  end
end
