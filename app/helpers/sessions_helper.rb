module SessionsHelper

	def sign_in(user)  
      session[:user_id] = user.id
      self.current_user = user
  end  

  def sign_out   
    self.current_user = nil
    session[:user_id] = nil
  end  

  def signed_in?  
    current_user.present?
  end  

  def current_user=(user)  
    @current_user = user  
  end  

  def current_user  
    @current_user ||= Account.find_by_id(session[:user_id])
  end

end