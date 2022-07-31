require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "rubocop"

desc 'Check syntax'
task :syntax do
  system('find lib/ | grep ".rb$" | xargs ruby -c')
end

desc 'Run Rubocop'
task(:rubocop) do
  cli = RuboCop::CLI.new
  cli.run
end

RSpec::Core::RakeTask.new(:spec)

task :default => [:syntax, :rubocop, :spec]
