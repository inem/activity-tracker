class ActivityService
  attr_reader :repo
  attr_accessor :config
  def initialize(repo)
    @repo = Git.open(repo)
    @config = {
      days: 5
    }
  end

  def commits_between_two_tags(hash1, hash2)
    commits = []
    repo.log.between(hash1, hash2).map do |l|
      commits << l.sha
    end
    commits
  end

  def commits_hash_per_days
    require "date"
    last_commit_date = Date.parse(repo.log.last.date.strftime("%Y-%m-%d"))
    first_commit_date = Date.parse(Time.now.strftime("%Y-%m-%d"))
    all_dates = (last_commit_date..first_commit_date).to_a.map { |d| d.strftime("%Y-%m-%d") }
    all_commits = repo.log
    users_hash = Hash.new { |hsh, key| hsh[key] = [] }
    all_dates.each do |date|
      users_hash[date] << 0
    end
    all_commits.each do |commit|
      commit_date = commit.date.strftime("%Y-%m-%d")
      users_hash[commit_date] << commit.sha
    end
    users_hash
  end

  def average_commits_count
    count = all_commits_count.reduce(:+).to_f/commits_hash_per_days.size
    count.round(2)
  end

  def median_commits_count
    arr = all_commits_count.sort
    arr[arr.size/2]
  end

  private

  def all_commits_count
    commits_hash_per_days.map { |_,v| v.size.to_i - 1 }
  end

end
