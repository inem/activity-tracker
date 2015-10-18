class User < ActiveRecord::Base

  after_save :init_exercises

  validates :name, :repo, presence: true
  has_many :exercises

  def tasks
    github = Github.new user: name, repo: repo
    github.repos.tags.each do |tag|
       #(github.repos.commits.get name, name, tag.commit.sha).commit.committer.date
    end
    github.repos.tags
  end

  def github_url
    "https://github.com/#{self.name}/#{self.repo}.git"
  end

  def clone_repo
    repo = Git.clone(github_url, "#{self.name}_#{self.repo}", :path => "#{Rails.root}/tmp")
    repo.dir.path
  rescue Git::GitExecuteError
    "#{Rails.root}/tmp/#{self.name}_#{self.repo}"
  end

  def repo_events
    Repository.new(clone_repo).events
  end

  def method_statistics
    repo_events.reverse.uniq(&:method_name)
  end

  private

  def init_exercises
    repo = Git.open(self.clone_repo)
    repo.tags.map do |tag|
      self.exercises.create(name: tag.name,
                            start_date: repo.gcommit(tag.objectish).date)
    end
  end

  def get_date
    Git.open(self.clone_repo).tags
  end
end
