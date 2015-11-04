class WidgetsController < ApplicationController

  def activity_chart
    name, repo = params[:repository].split('/')
    @user = User.new(repo: repo, name: name)
    repository = @user.clone_repo
    @statistics = ActivityService.new(repository).commits_hash_per_days.to_json
  end
end
