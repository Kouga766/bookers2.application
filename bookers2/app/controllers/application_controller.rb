class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top, :about]
	before_action :configure_permitted_parameters, if: :devise_controller?

 
  def after_sign_in_path_for(resource)
    flash[:notice]= "Signed in successfully."
    user_path(current_user)
  end

  def after_sign_out_path_for(resource)
    flash[:notice]= "Signed out successfully."
  end
  
 protected
  def configure_permitted_parameters
     added_attrs = [ :email, :name, :password, :password_confirmation ]

    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
  end
  
  def
after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :member
        root_path
    elsif resource_or_scope == :admin
        new_admin_session_path
    else
        root_path
    end
  end
end
