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
      users_hash = Hash.new {|hsh, key| hsh[key] = [] }
      temp_hash.each do |k,v|
        users_hash[v] << k
      end
      users_hash
    end

    def commits_between_two_tags(tag1,tag2)
      commit1 = commit_hash(tag1)
      commit2 = commit_hash(tag2)
      repo.log.between(commit_1, commit_2).map do |l|
        binding.pry
      end
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
