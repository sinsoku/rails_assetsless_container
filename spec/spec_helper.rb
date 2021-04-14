# frozen_string_literal: true

require "simplecov"
SimpleCov.start do
  track_files "lib/**/*.rb"
  add_filter "lib/rails_assetsless_container/version.rb"
  add_filter "/spec/"

  enable_coverage :branch
  minimum_coverage 90
end

require "rails"
require "rails_assetsless_container"
require "webmock/rspec"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

RSpec.shared_context "with rails_root" do
  let(:tmpdir) { File.expand_path("tmp", __dir__) }
  let(:rails_root) { Pathname(Dir.mktmpdir(nil, tmpdir)) }

  before { allow(Rails).to receive(:root).and_return(rails_root) }

  after { FileUtils.remove_entry(rails_root) }
end
