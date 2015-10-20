module Activity
  class Project
    attr_reader :repo
    def initialize(repo)
      @repo = Git.open(repo)
    end

    def commiters
      repo.log.map do |l|
        committer_name(l)
      end.uniq!
    end

    def commits_frequency(days)
      hash = {}
      repo.log.since('2 days ago').map do |l|
        hash[commit_date(l).to_s] = committer_name(l)
      end
      hash
    end

    private

    def commit_date(sha)
      repo.gcommit(sha).committer.date
    end

    def committer_name(sha)
      repo.gcommit(sha).committer.name
    end
  end
end
