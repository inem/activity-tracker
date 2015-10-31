module Activity
  class Project
    attr_reader :repo
    attr_accessor :config
    def initialize(repo)
      @repo = Git.open(repo)
      @config = {
        days: 5
      }
    end

    def commiters
      repo.log.map do |l|
        committer_name(l)
      end.uniq!
    end

    def commits_per_days
      temp_hash = {}
      repo.log.since("#{config[:days]} days ago").map do |l|
        temp_hash[l.sha] = committer_name(l)
      end
      users_hash = Hash.new { |hsh, key| hsh[key] = [] }
      temp_hash.each do |k, v|
        users_hash[v] << k
      end
      users_hash
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
      first_commit_date = Date.parse(repo.log.first.date.strftime("%Y-%m-%d"))
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

    private

    def commit_message(sha)
      repo.gcommit(sha).message
    end

    def commit_date(sha)
      repo.gcommit(sha).committer.date
    end

    def committer_name(sha)
      repo.gcommit(sha).committer.name
    end
  end
end
