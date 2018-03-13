class SessionsController < ApplicationController

	include SessionsHelper
  
  def login  
		render 'login', :layout => nil
  end  

  def create_login_session
    user = Account.find_by(name: params[:name])  
    if user && user.authenticate(params[:password])  
      sign_in user
      redirect_to root_path  
    else  
      flash[:error] = '用户名或者密码错误'
      render 'login', :layout => nil
    end  
  end  

  def destroy  
    sign_out
    redirect_to root_path  
  end  
  
end  