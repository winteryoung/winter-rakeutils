require 'rake'
require 'fileutils'

CLOBBER.include TARGET_DIR

module WinterRakeUtils
  extend FileUtils

  module_function

  def git_working_dir_clean?
    `git status`.lines.each do |line|
      if line.index "Changes to be committed"
        return false
      end
    end
    return true
  end

  def ensure_dir d
    unless File.exists? d
      mkdir_p d
      unless File.exists? d
        sleep 0.01
        ensure_dir d
      end
    end
  end

  def git_commit_push msg = "auto"
    sh "git add -A"
    unless git_working_dir_clean?
      sh "git commit -m #{msg}"
      sh "git push"
    end
  end

  def within_dir dir, &block
    pwd = Dir.pwd
    Dir.chdir dir
    begin
      block.call
    ensure
      Dir.chdir pwd
    end
  end

  def load_gem_tasks
    spec = Gem::Specification.find_by_name 'winter_rakeutils'
    load "#{spec.gem_dir}/lib/winter_gemtasks.rake"
  end

  def load_git_tasks
    spec = Gem::Specification.find_by_name 'winter_rakeutils'
    load "#{spec.gem_dir}/lib/winter_gittasks.rake"
  end

  def load_common_tasks
    spec = Gem::Specification.find_by_name 'winter_rakeutils'
    load "#{spec.gem_dir}/lib/winter_commontasks.rake"
  end
end
