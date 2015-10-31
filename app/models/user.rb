class User < ActiveRecord::Base
  require_relative "#{Rails.root}/app/services/activity_service"

  after_save :init_exercises

  validates :name, :repo, presence: true
  has_many :exercises

  def tasks
    github = Github.new user: name, repo: repo
    github.repos.tags
  end

  def github_url
    "https://github.com/#{name}/#{repo}.git"
  end

  def clone_repo
    repo = Git.clone(github_url, "#{name}_#{repo}", path: "#{Rails.root}/tmp")
    repo.dir.path
  rescue Git::GitExecuteError
    "#{Rails.root}/tmp/#{name}_#{repo}"
  end

  def repo_events
    Repository.new(clone_repo).events
  end

  def method_statistics
    repo_events.reverse.uniq(&:method_name)
  end

  private

  def init_exercises
    repo = Git.open(clone_repo)
    repo.tags.each_with_index.map do |tag, i|
      exercises.create(name: tag.name,
                       start_date: get_dates(repo, i)[:start_date],
                       end_date: get_dates(repo, i)[:end_date])
    end
  end

  def get_dates(repo, i)
    hash = {}
    if i == 0
      hash[:start_date] = repo.log(count = 50).last.date
      hash[:end_date] = repo.gcommit(repo.tags.first.objectish).date
    else
      hash[:start_date] = repo.gcommit(repo.tags[i-1].objectish).date
      hash[:end_date] = repo.gcommit(repo.tags[i].objectish).date
    end
    hash
  end
end
