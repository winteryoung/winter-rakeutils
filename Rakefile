require "rubygems"
require_relative 'lib/winter_rakeutils'

include WinterRakeUtils

app_name = "winter_rakeutils"

gem_spec = Gem::Specification::load("#{app_name}.gemspec")
ver = gem_spec.version

task :gitcommit do
  git_commit_push
end

task :clean do
  rm_rf "target"
end

gem_source_files = FileList.new "lib/*", "bin/*", "#{app_name}.gemspec"
gem_file = FileList.new "target/#{app_name}-#{ver}.gem"

rule /target\/.+?\.gem/ => gem_source_files do |t|
  ensure_dir "target"
  sh "gem build #{app_name}.gemspec"
  mv "#{app_name}-#{ver}.gem", "target"
end

task :build => "target/#{app_name}-#{ver}.gem"

task :local => [ :clean, :build ] do
  sh "gem uninstall #{app_name}"
  pwd = Dir.pwd
  Dir.chdir "target"
  sh "gem install #{app_name}-#{ver}.gem"
  Dir.chdir pwd
end

task :test do
  tests = FileList.new "test/**/*_test.rb"
  tests.each do |test|
    system "ruby #{test}"
  end
end

task :publish => [ :clean, :build ] do
  sh "gem push #{gem_file}"
end
