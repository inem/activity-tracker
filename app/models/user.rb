class User < ActiveRecord::Base

  validates :name, :repo, presence: true


  def tasks
    github = Github.new user: name, repo: repo
    github.repos.tags.each do |tag|
       #(github.repos.commits.get name, name, tag.commit.sha).commit.committer.date
    end
    github.repos.tags
  end
end
