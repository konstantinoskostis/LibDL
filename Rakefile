require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "rubocop"

desc 'Run Rubocop'
task(:rubocop) do
  cli = RuboCop::CLI.new
  cli.run
end

RSpec::Core::RakeTask.new(:spec)

task :default => [:rubocop, :spec]
