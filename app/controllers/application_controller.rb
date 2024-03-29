class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user_session, :current_user
  
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Sorry! You can't access that page"
    redirect_to root_url
  end
  
  private
   
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end
    
    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.user
    end
    
    def load_user_using_perishable_token
      @user = User.find_by_perishable_token(params[:id])
      unless @user
        flash[:notice] = "The url you entered isn't valid, try copy and pasting in out of your email again"
        redirect_to root_url
      end
    end
end
