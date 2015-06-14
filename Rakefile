require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rainbow/ext/string' unless String.respond_to?(:color)
require 'rubocop/rake_task'

RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
end

RuboCop::RakeTask.new(:rubocop)
task default: %i(spec rubocop)
