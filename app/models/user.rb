class User < ActiveRecord::Base
  def tasks
    github = Github.new user: name, repo: repo
    # github.repos.tags.each do |tag|
    #   p (github.repos.commits.get "justcxx", "skillgrid", tag.commit.sha).commit.committer.date
    # end
    # github.repos.tags
    []
  end
end
