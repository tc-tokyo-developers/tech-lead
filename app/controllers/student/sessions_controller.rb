class Student::SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def callback
    auth = request.env['omniauth.auth']
    user = Student::User.find_by(provider: auth[:provider], uid: auth[:uid])
    if user.blank?
      user = Student::User.create_with_omniauth(auth)
      redirect_to edit_student_accounts_path, notice: 'ユーザー情報を登録してください'
    else
      redirect_to root_url, notice: 'ログインしました'
    end
    session[:user_id] = user.id
  end

  def destroy
    reset_session
    redirect_to root_url, notice: 'ログアウトしました'
  end
end
