class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authorize

  delegate :allow?, to: :current_permission
  helper_method :allow?

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def current_session
    if @current_session
      @current_session
    else
      if session[:current_id]
        @current_session = CurrentSession.find(session[:current_id])
      end 
    end
  rescue ActiveRecord::RecordNotFound
    session[:current_id] = nil
    #redirect_to login_url
  end
  helper_method :current_session

  def current_permission
    @current_permission ||= Permission.new(current_user)
  end

  def admin?
    true if @current_user && @current_user.student.group.name == 'Lehrer'
  end
  helper_method :admin?
  
  def authorize
    if !current_permission.allow?(params[:controller], params[:action])
      redirect_to root_url, alert: "Not authorized."
    end
  end

end
