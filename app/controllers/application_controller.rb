class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :check_for_cancel, :only => [:create, :update] 

  def check_for_cancel
    unless params[:cancel].blank?
      target = params[:cancel_to].present? ? params[:cancel_to] : :root
      redirect_to(target)
    end
  end 

end
