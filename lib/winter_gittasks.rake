module WinterRakeUtils
  module_function

  def git_working_dir_clean?
    `git status`.lines.each do |line|
      if line.index "Changes to be committed"
        return false
      end
    end
    return true
  end

  def git_commit_push msg = "auto"
    sh "git add -A"
    unless git_working_dir_clean?
      sh "git commit -m #{msg}"
      sh "git push"
    end
  end
end

task :gitcommit do
  WinterRakeUtils.git_commit_push
end
