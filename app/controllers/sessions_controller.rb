class SessionsController < Devise::SessionsController


  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in(resource_name, resource)
    session[:user_id] = resource.id

      respond_to do |format|
        if user_signed_in?
          format.html { redirect_to home_path, notice: 'User Signed In' }

        else
          format.html { render action: 'new',alert: "Invalid user/password combination" }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
  end


end