# frozen_string_literal: true

RSpec.describe RailsAssetslessContainer::Strategy::Log do
  include_context "with rails_root"

  let(:output) { StringIO.new }
  let(:strategy) { described_class.new(Logger.new(output)) }
  let(:manifest_path) { "path/dummy.json" }

  describe "#after_sprockets" do
    before { strategy.after_sprockets(manifest_path) }

    it { expect(output.string).to match(%r{INFO -- : after_sprockets: path/dummy.json}) }
  end

  describe "#after_webpacker" do
    before { strategy.after_webpacker(manifest_path) }

    it { expect(output.string).to match(%r{INFO -- : after_webpacker: path/dummy.json}) }
  end

  describe "#write_sprockets_manifest" do
    before { strategy.write_sprockets_manifest(manifest_path) }

    it { expect(output.string).to match(%r{INFO -- : write_sprockets_manifest: path/dummy.json}) }
  end

  describe "#write_webpacker_manifest" do
    before { strategy.write_webpacker_manifest(manifest_path) }

    it { expect(output.string).to match(%r{INFO -- : write_webpacker_manifest: path/dummy.json}) }
  end
end
