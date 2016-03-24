require 'rake/clean'

APP_NAME = "winter_rakeutils"
TARGET_DIR = "target"

load 'lib/gemtasks.rake'

CLOBBER.include TARGET_DIR

task :local => [ :clobber, :local_gem ]
