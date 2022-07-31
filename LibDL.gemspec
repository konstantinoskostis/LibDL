# frozen_string_literal: true

require_relative 'lib/lib_dl/version'

Gem::Specification.new do |spec|
  spec.name          = 'LibDL'
  spec.version       = LibDL::VERSION
  spec.authors       = ['Konstantinos Kostis']
  spec.email         = ['kekostis@gmail.com']

  spec.summary       = 'LibDL is a deep-learning toolkit written in pure ruby :-)'
  spec.homepage      = 'https://github.com'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.metadata['source_code_uri'] = 'https://github.com'
  spec.metadata['changelog_uri'] = 'https://github.com'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'pry-byebug', '~> 3.9.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 1.24.0'
  spec.add_development_dependency 'solargraph', '~> 0.44.2'
end
