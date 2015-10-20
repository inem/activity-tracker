class ProjectsController < ApplicationController
  #Потом поправлю
  require_relative "#{Rails.root}/app/services/activity_service"
  #...
  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to @project
    else
      redirect_to :index #test
    end
  end

  def show
    @project = Project.find(params[:id])
    @activity = Activity::Project.new(@project.clone_repo)
  end

  private

  def project_params
    params.require(:project).permit(:repo)
  end
end
