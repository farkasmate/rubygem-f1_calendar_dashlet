# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rubocop/rake_task'

RuboCop::RakeTask.new

task default: :rubocop

desc 'Create Docker image'
task :image do
  sh 'docker build -t matefarkas/f1-calendar-dashlet .'
end

desc 'Run development server'
task :dev do
  sh 'unicorn'
end
