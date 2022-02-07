class ApplicationController < ActionController::Base
  include Tenantable
  before_action :set_current_client
  helper_method :logged_in?

  def set_current_client
    puts "session[:current_client_id]: #{session[:current_client_id]}"
    @current_client = session[:current_client_id] && Client.find_by_id(session[:current_client_id]) unless defined?(@current_client)
    @current_client
  end

  def current_user=(user)
    session[:current_client_id] = user && user.id
    remove_instance_variable('@current_client') if defined?(@current_client) #Force reload in current_client
    current_client
  end

  def logged_in?
    # !! = get boolean value from any value
    !!set_current_client
  end

  def require_login
    unless logged_in?
      flash[:error] = 'You must be logged in to view this page'
      redirect_to login_path
    end
  end

  def authorized
    redirect_to login_path unless logged_in?
  end
end
