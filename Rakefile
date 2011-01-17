require 'bundler'
Bundler::GemHelper.install_tasks

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |s|
  s.rspec_opts = "--format=#{ENV['RSPEC_FORMAT'] || 'nested'} --colour"
end

task :default => :spec
