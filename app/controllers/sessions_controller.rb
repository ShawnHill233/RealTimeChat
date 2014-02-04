class SessionsController < Devise::SessionsController


  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in(resource_name, resource)
    session[:user_id] = resource.id
    if resource.isadmin?
      redirect_to admin_users_path
      else
      redirect_to home_path
    end

  end


end