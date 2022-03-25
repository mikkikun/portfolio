class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.account_activation(@user).deliver_now
      flash[:info] = '認証用メールを送信しました。登録時のメールアドレスから認証を済ませてください'
      redirect_to root_url
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page]).per(10)
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = 'プロフィールの更新に成功しました'
      redirect_to @user
    else
      flash.now[:danger] = 'プロフィールの編集に失敗しました'
      redirect_to edit_user_path(@user)
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:warning] = 'ログインしてください'
      redirect_to login_url
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end
