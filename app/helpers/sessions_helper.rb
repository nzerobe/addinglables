module SessionsHelper
  
   def log_in(user)
    session[:user_id] = user.id
  end
  
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  def logged_in?
    current_user.present?
  end
  
  
    
    def authenticate      
       if session[:user_id] == nil
        flash[:alert] = "can't access this page unless logged in"
        redirect_to new_session_path
        false
    #    else
    #     redirect_to new_user_path
       end
    end
  
  
  
end
