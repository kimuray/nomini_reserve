class Admin::UsersController < AdminController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.page(params[:page])
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to admin_user_url(@user), notice: 'User was successfully created.'
    else
      render :new
    end
  end

  def update
    if @user.update_without_password(user_params)
      redirect_to admin_user_url(@user), notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_url, notice: 'User was successfully destroyed.'
  end

  private
 
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.fetch(:user, {}).permit(
      :email, :password, :password_confirmation, :confirmed_at, :l_name, :f_name, :l_name_kana, :f_name_kana,
      :phone_number, :enterprise_name, :bank_name, :bank_branch_name, :bank_account_number, :occupation, :point_count 
    )
  end
end
