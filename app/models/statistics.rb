module Statistics

  def commits(sha1, sha2)
    ActivityService.new(self.repo_path).commits_between_two_tags(sha1,sha2)
  end

  def chart_statistics
    ActivityService.new(self.repo_path).commits_hash_per_days
  end

  def tasks
    github = Github.new user: name, repo: repo
    github.repos.tags
  end

  def repo_events
    Repository.new(repo_path).events
  end

  def method_statistics
    repo_events.reverse.uniq(&:method_name)
  end

end
