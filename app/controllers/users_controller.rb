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
  end

  private

  def user_params
    params.require(:user).permit(:name, :repo)
  end
end
