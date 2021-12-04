require "rubygems"
require "cucumber"
require "cucumber/rake/task"

task default: :lint

task :lint do
  sh "rubocop --format html -o rubocop.html"
end
