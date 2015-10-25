class Exercise < ActiveRecord::Base
  belongs_to :user

  def children_hashes(i)
    hash = {}
    repo = Git.open(self.user.clone_repo)
    if i == 0
      hash[:sha1] = repo.log(count = 50).last.sha
      hash[:sha2] = commit_hash(repo,Exercise.all[i].name)
    else
      hash[:sha1] = commit_hash(repo,Exercise.all[i-1].name)
      hash[:sha2] = commit_hash(repo,Exercise.all[i].name)
    end
    hash.values.join(",")
  end

  def commit_hash(repo,tag)
    repo.tag(tag).sha
  end

end
