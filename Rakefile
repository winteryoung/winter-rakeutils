require 'rake/clean'

APP_NAME = "winter_rakeutils"
TARGET_DIR = "target"

load 'lib/winter_commontasks.rake'
load 'lib/winter_gemtasks.rake'
load 'lib/winter_gittasks.rake'

task :default => [ :publish_gem, :gitcommit ]
task :local => [ :clobber, :local_gem ]
task :publish => [ :local, :publish_gem ]

task :test do
  tests = FileList.new "test/**/*_test.rb"
  tests.each do |test|
    system "ruby #{test}"
  end
end
