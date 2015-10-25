class UsersController < ApplicationController
  #Потом поправлю
  require_relative "#{Rails.root}/app/services/activity_service"
  #...
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
    require "analytics"

    @user = User.find_by(id: params[:id])
    @statistics = @user.method_statistics
    @method_churns = method_churns @user.repo_events
  end

  def commits_frequency
    user = User.find(params[:id])
    repo = user.clone_repo
    @commits = Activity::Project.new(repo).commits_between_two_tags(
                                          params[:sha1], params[:sha2])

    render partial: "commits"
  end

  private

  def user_params
    params.require(:user).permit(:name, :repo)
  end
end
