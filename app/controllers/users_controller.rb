class UsersController < ApplicationController
  def show
    @user = User.includes(diaries:[{comments: :user}]).find(params[:id])
  end

  def new
    @user = User.new
  end

  def create

    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "ようこそ、" + @user.first_name
      redirect_to @user
    else
      render 'new'
    end
  end

  private

    def user_params
      user_params = params.require(:user).permit(:first_name, :family_name, :username, :email, :password, :password_confirmation)
    end

end
