class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

  def render_403
    render :text => "Forbidden", :status => 403, :layout => false
  end
end
