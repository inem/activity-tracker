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

  private

  def init_exercises
    self.tasks.each do |t|
      self.exercises.create(name: t.name)
    end
  end

end
