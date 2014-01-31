class Admin::UsersController < Admin::AdminController
  before_action :set_admin, only: [:show, :edit, :update, :destroy]

  def index
    @user = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(admin_params)
    if @user.save
      redirect_to admin_users_path , notice:'User created'
    else
      render  'new'
    end
  end

  def edit

  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_admin
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def admin_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end