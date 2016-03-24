require 'rake/clean'

APP_NAME = "winter_rakeutils"
TARGET_DIR = "target"

load 'lib/winter_gemtasks.rake'
load 'lib/winter_gittasks.rake'

task :local => [ :clobber, :local_gem ]
task :publish => [ :clobber, :publish_gem ]
