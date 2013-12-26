# encoding: utf-8

class BidsController < ApplicationController
  extend Memoist

  before_filter :authenticate_user!
  before_filter :render_403, unless: :current_user_is_project_author?, only: :choose

  def create
    bid.update_attribute(:user, current_user)
    redirect_to project
  end

  def choose
    bid.choose
    redirect_to project
  end

  protected

  def current_user_is_project_author?
    current_user == project.author
  end

  def bid
    if params[:bid_id]
      project.bids.find(params[:bid_id])
    else
      project.bids.new(params[:bid])
    end
  end
  memoize :bid

  def project
    Project.find(params[:project_id])
  end
  memoize :project
end
