require 'rake'

module WinterRakeUtils
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
end

task :gitcommit do
  git_commit_push
end
