# encoding: utf-8

class ProjectsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :render_403, unless: :current_user_is_author?, only: [:edit, :update, :destroy]

  helper_method :projects, :project, :bids, :current_user_is_author?

  def create
    if project.save
      redirect_to project
    else
      render :new
    end
  end

  def update
    if project.update_attributes(params[:project])
      redirect_to project
    else
      render :edit
    end
  end

  def destroy
    project.destroy
    redirect_to projects_path
  end

  protected

  def current_user_is_author?
    current_user == project.author
  end

  def projects
    @projects ||= Project.paginate(page: params[:page])
  end

  def project
    @project ||= begin
      if params[:id].present?
        Project.find(params[:id])
      else
        current_user.projects.new(params[:project])
      end
    end
  end

  def bids
    @bids ||= project.bids.paginate(page: params[:page])
  end
end
