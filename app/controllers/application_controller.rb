class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :require_login, :except => [:login, :create_login_session]

  def require_login
  	if session[:user_id].blank?
      redirect_to '/login'
    end
  end
end
