module SessionsHelper
  def sign_in(user)
    session[:remember_token] = [user.id, user.salt]
    # cookies.permanent.signed[:remember_token] = [user.id, user.salt]
    current_user = user
  end
  
  def sign_out
    session[:remember_token] = nil
    # cookies.delete(:remember_token)
    current_user = nil
  end
  
  def current_user=(user)
    @current_user = user
  end
  
  def current_user
    @current_user ||= user_from_remember_token
  end
  
  def signed_in?
    !current_user.nil?
  end
  
  def current_user?(user)
    user == current_user
  end
  
  def deny_access
    store_location
    redirect_to signin_path, :notice => "Please sign in to access this page."
  end
  
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end
  
  private
  def user_from_remember_token
    User.authenticate_with_salt(*remember_token)
  end

  def remember_token
    session[:remember_token] || [nil, nil]
    # cookies.signed[:remember_token] || [nil, nil]
  end
  
  def store_location
    session[:return_to] = request.fullpath
  end
  
  def clear_return_to
    session[:return_to] = nil
  end
end