class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authorize
  protected
  def authorize
  	redirect_to login_url, alert: "Not authorize" #if current_user.nil?
  end


  private
  def current_user
  	#@current_user ||= User.find(session[:session_id]) if session[:session_id]
    #raise session.to_yaml
    if @current_user
      @current_user
    else
      if session[:current_id]
        @current_user = CurrentSession.find(session[:current_id])
      end 
    end
  rescue ActiveRecord::RecordNotFound
    session[:current_id] = nil
    #redirect_to login_url
  end

  def admin?
   	true if @current_user && @current_user.group_id == 1
  end

  helper_method :current_user, :admin?

  def restricted
    redirect_to test_students_url, alert: "Restricted. Only for admins" if @current_user.group_id != 1
  end

end
