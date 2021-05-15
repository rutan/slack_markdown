# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'slack_markdown/version'

Gem::Specification.new do |spec|
  spec.name          = 'slack_markdown'
  spec.version       = SlackMarkdown::VERSION
  spec.authors       = ['Ru/MuckRu']
  spec.email         = ['ru_shalm@hazimu.com']

  spec.summary       = 'Convert Slack message markdown to HTML.'
  spec.description   = 'Convert Slack message markdown to HTML.'
  spec.homepage      = 'https://github.com/rutan/slack_markdown'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'html-pipeline', '~> 2.0'
  spec.add_dependency 'escape_utils'
  spec.add_dependency 'gemoji'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 3.2'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rubocop', '~> 0.40.0'
end
