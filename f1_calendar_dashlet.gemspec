# frozen_string_literal: true

require_relative 'lib/f1_calendar_dashlet/version'

Gem::Specification.new do |spec|
  spec.name          = 'f1_calendar_dashlet'
  spec.version       = F1CalendarDashlet::VERSION
  spec.authors       = ['Mate Farkas']
  spec.email         = ['mate.farkas@sch.hu']

  spec.summary       = 'F1 Calendar Dashlet'
  spec.homepage      = 'https://github.com/farkasmate/rubygem-f1_calendar_dashlet'

  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.required_ruby_version = Gem::Requirement.new('~> 3.0')

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.2'
  spec.add_development_dependency 'pry', '~> 0.14'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rubocop', '~> 1.14'
  spec.add_development_dependency 'rubocop-rake', '~> 0.5'

  spec.add_runtime_dependency 'dashlet', '~> 2.0'
end
