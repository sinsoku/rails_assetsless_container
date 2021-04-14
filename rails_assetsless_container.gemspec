# frozen_string_literal: true

require_relative "lib/rails_assetsless_container/version"

Gem::Specification.new do |spec|
  spec.name          = "rails_assetsless_container"
  spec.version       = RailsAssetslessContainer::VERSION
  spec.authors       = ["Takumi Shotoku"]
  spec.email         = ["sinsoku.listy@gmail.com"]

  spec.summary       = "Starts a server without including assets in the container."
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/sinsoku/rails_assetsless_container"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.4.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/sinsoku/rails_assetsless_container/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport", ">= 5.2"
  spec.add_dependency "railties", ">= 5.2"
  spec.add_dependency "sprockets", ">= 3"
end
