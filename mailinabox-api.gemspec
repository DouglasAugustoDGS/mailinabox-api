
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "mailinabox/api/version"

Gem::Specification.new do |spec|
  spec.name          = "mailinabox-api"
  spec.version       = Mailinabox::Api::VERSION
  spec.authors       = ["Sebastian"]
  spec.email         = ["sebastian.johnsson@gmail.com"]

  spec.summary       = %q{Mail-in-a-box Ruby API Client}
  spec.description   = %q{Mail-in-a-box: Ruby API Client to interact with the API endpoints}
  spec.homepage      = "https://github.com/SebastianJ/mailinabox-api"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  
  spec.add_dependency "faraday", "~> 0.15.2"

  spec.add_development_dependency "bundler",    "~> 1.16.2"
  spec.add_development_dependency "rake",       "~> 12.3.1"
  spec.add_development_dependency "rspec",      "~> 3.7.0"
  spec.add_development_dependency "rdoc",       "~> 6.0.4"
  spec.add_development_dependency "vcr",        "~> 4.0"
  spec.add_development_dependency "webmock",    "~> 3.4.2"
  spec.add_development_dependency "pry",        "~> 0.11.3"
end
