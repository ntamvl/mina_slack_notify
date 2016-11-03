# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mina_slack_notify/version'

Gem::Specification.new do |spec|
  spec.name          = "mina_slack_notify"
  spec.version       = MinaSlackNotify::VERSION
  spec.authors       = ["Tam Nguyen"]
  spec.email         = ["ntamvl@gmail.com"]

  spec.summary       = "Adds tasks to aid in the Slack notifications"
  spec.description   = "Mina bindings for Slack"
  spec.homepage      = "https://github.com/ntamvl/mina_slack_notify"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "mina", "~> 1.0"

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 11.2"
  spec.add_development_dependency "httparty", "~> 0"
  spec.add_development_dependency "rubygems-tasks", "~> 0.2"
  spec.add_development_dependency "yard", "~> 0.8"
end
