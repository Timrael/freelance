# encoding: utf-8

class BidsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :render_403, unless: :current_user_is_project_author?, only: :select

  def create
    bid.user = current_user
    bid.save
    redirect_to project
  end

  def select
    bid.select_it
    redirect_to project
  end

  protected

  def current_user_is_project_author?
    current_user == project.author
  end

  def bid
    @bid ||= begin
      if params[:bid_id]
        project.bids.find(params[:bid_id])
      else
        project.bids.new(params[:bid])
      end
    end
  end

  def project
    @project ||= Project.find(params[:project_id])
  end
end
