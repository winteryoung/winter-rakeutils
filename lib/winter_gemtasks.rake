require "rubygems"
require_relative 'winter_rakeutils'

include WinterRakeUtils

load File.expand_path('../winter_commontasks.rake', __FILE__)

gem_spec = Gem::Specification::load("#{APP_NAME}.gemspec")
ver = gem_spec.version
gem_source_files = FileList.new "lib/*", "bin/*", "#{APP_NAME}.gemspec"
gem_file = "#{TARGET_DIR}/#{APP_NAME}-#{ver}.gem"

rule /#{TARGET_DIR}\/.+?\.gem/ => [ TARGET_DIR, *gem_source_files ] do |t|
  sh "gem build #{APP_NAME}.gemspec"
  mv "#{APP_NAME}-#{ver}.gem", TARGET_DIR
end

task :build_gem => [ TARGET_DIR, "#{TARGET_DIR}/#{APP_NAME}-#{ver}.gem" ]

task :clean_gem do
  rm_rf gem_file
end

task :local_gem => [ :clean_gem, :build_gem ] do
  sh "gem uninstall -ax #{APP_NAME}"
  within_dir TARGET_DIR do
    sh "gem install #{APP_NAME}-#{ver}.gem"
  end
end

task :publish_gem => [ :local_gem ] do
  sh "gem push #{gem_file}"
end
