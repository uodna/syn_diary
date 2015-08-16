class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(username: params[:session][:username].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or diaries_path
    else
      flash.now[:error] = 'ユーザー名、パスワードの組み合わせに誤りがあります'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end

end
