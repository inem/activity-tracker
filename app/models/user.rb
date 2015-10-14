class User < ActiveRecord::Base
  def self.activities
    User.all.map do |u|
      {
        user: u.name,
        repo: u.repo,
        tasks: u.tasks
      }
    end
  end

  def tasks
    require "github_api"
    github = Github.new
    github.repos.tags "justcxx", "skillgrid" do |tag|
      p (github.repos.commits.get "justcxx", "skillgrid", tag.commit.sha).commit.commiter.date
    end
  end
end
