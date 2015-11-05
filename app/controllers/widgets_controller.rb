class WidgetsController < ApplicationController

  def activity_chart
    name, repo = params[:repository].split('/')
    @user = User.find_or_create_by(repo: repo, name: name)
    repository = @user.clone_repo
    @statistics = ActivityService.new(repository).commits_hash_per_days.to_json
  end

  def tags_duration_chart
    name, repo = params[:repository].split('/')
    @user = User.find_or_create_by(repo: repo, name: name)
    @statistics = @user.exercises.map do |exercise|
      { name: exercise.name, duration: exercise.end_date - exercise.start_date }
    end
    @statistics = @statistics.to_json
  end
end
