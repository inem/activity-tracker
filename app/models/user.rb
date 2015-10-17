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

  private

  def init_exercises
    self.tasks.each do |t|
      self.exercises.create(name: t.name)
    end
  end
end
