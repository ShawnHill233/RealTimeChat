class Admin::UsersController < Admin::AdminController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path , notice:'User created'
    else
      render  'new'
    end
  end

  def edit

  end

  def update
   if @user.update(user_params)
     redirect_to admin_users_path, notice: 'User was successfully updated.'
   else
     render action: 'edit'
   end
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :isadmin)
  end
end