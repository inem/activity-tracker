require "analytics"
require_relative "#{Rails.root}/app/services/activity_service"

class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path
    else
      render :new
    end
  end

  def statistics

    @user = User.find_by(id: params[:id])
    @statistics = @user.method_statistics
    @method_churns = method_churns @user.repo_events
  end

  def commits_frequency
    @user = User.find(params[:id])
    repo = @user.clone_repo
    @commits = Activity::Project.new(repo).commits_between_two_tags(
                                          params[:sha1], params[:sha2])
    render partial: "commits"
  end

  def chart_statistics
    @user = User.find(params[:id])
    repo = @user.clone_repo
    @statistics = Activity::Project.new(repo).commits_hash_per_days
    render json: @statistics.to_json
  end

  private

  def user_params
    params.require(:user).permit(:name, :repo)
  end
end
