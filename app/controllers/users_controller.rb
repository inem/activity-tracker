require "analytics"

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
    @commits = @user.commits(params[:sha1], params[:sha2])
    render partial: "commits"
  end

  def chart_statistics
    @user = User.find(params[:id])
    @statistics = @user.chart_statistics
    render json: @statistics.to_json
  end

  private

  def user_params
    params.require(:user).permit(:name, :repo)
  end
end
