class SessionsController < Devise::SessionsController


  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in(resource_name, resource)
    session[:user_id] = resource.id
    if !session[:return_to].blank?
      redirect_to session[:return_to]
      session[:return_to] = nil
    else
      redirect_to dashboard_path
    end

  end


end