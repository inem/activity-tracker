class DashboardController < ApplicationController
  def index
    @users = User.all
  end

  def update_activities
  end
end
