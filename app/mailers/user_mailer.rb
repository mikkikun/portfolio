class UserMailer < ApplicationMailer
  def account_activation(user)
    @user = user
    mail to: user.email, subject: '【重要】Card Matchよりアカウント有効化のためのメールを届けました'
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: '【重要】Card Matchよりパスワード再設定のためのメールを届けました'
  end
end
