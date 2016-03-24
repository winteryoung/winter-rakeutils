require_relative 'winter_rakeutils'

include WinterRakeUtils

task :gitcommit do
  git_commit_push
end
