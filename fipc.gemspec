# frozen_string_literal: true

require_relative "lib/fipc/version"

Gem::Specification.new do |spec|
  spec.name = "fipc"
  spec.version = Fipc::VERSION
  spec.authors = ["Won Rhim"]
  spec.email = ["wwrk22@gmail.com"]

  spec.summary = <<~SUMMARY.chomp.gsub("\n", " ")
    An opinionated collector and organizer of financial information for public
    companies that file with the SEC.
  SUMMARY
  spec.description = <<~DESCRIPTION.chomp.gsub("\n", " ")
    The fipc gem fetches financial information of public companies using the
    SEC's EDGAR API. It then processes the raw JSON data retrieved to produce
    organized and meaningful financial information for analyses by users.
  DESCRIPTION

  spec.homepage = "https://rubygems.org/gems/fipc"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/wwrk22/fipc"
  spec.metadata["changelog_uri"] = "https://github.com/wwrk22/fipc/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html

  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubocop", "~> 1.21"
end
