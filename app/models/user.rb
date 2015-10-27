class User < ActiveRecord::Base
  #Потом поправлю
  require_relative "#{Rails.root}/app/services/activity_service"
  #...
  after_save :init_exercises

  validates :name, :repo, presence: true
  has_many :exercises


  def chart_statistics
    hash = {}
    activity = Activity::Project.new(self.clone_repo)
    self.exercises.each_with_index do |e,i|
      hash[e.name] = activity.commits_between_two_tags(e.children_hashes(i).split(',').first,
                              e.children_hashes(i).split(',').second)
    end
    hash
  end

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
    repo.tags.each_with_index.map do |tag,i|
      self.exercises.create(name: tag.name,
                            start_date: get_dates(repo,i)[:start_date],
                            end_date: get_dates(repo,i)[:end_date])
    end
  end

#Перенести методы в отедльный модуль, и включить его в User.rb
  def get_dates(repo,i)
    hash = {}
    if i == 0
      #count = 50 -- макс. размер получаемых коммитов за раз
      hash[:start_date] = repo.log(count = 50).last.date
      hash[:end_date] = repo.gcommit(repo.tags.first.objectish).date
    else
      hash[:start_date] = repo.gcommit(repo.tags[i-1].objectish).date
      hash[:end_date] = repo.gcommit(repo.tags[i].objectish).date
    end
    hash
  end

  # def get_date
  #   Git.open(self.clone_repo).tags
  # end
end
