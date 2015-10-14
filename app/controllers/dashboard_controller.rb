class DashboardController < ApplicationController
  def index
    @users = User.activities
  end
end
