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
      temp_hash = {}
      repo.log.since("#{days} days ago").map do |l|
        temp_hash[l.sha] = committer_name(l)
      end
      users_hash = Hash.new {|hsh, key| hsh[key] = [] }
      temp_hash.each do |k,v|
        users_hash[v] << k
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
