class Student::SessionsController < ApplicationController
  def callback
    auth = request.env['omniauth.auth']
    user = login_or_register_user(auth)
    session[:user_id] = user.id
    redirect_to root_url
  end

  def destroy
    reest_session
    redirect_to root_url
  end

  private

  def login_or_register_user(auth)
    user = User.find_by(provider: auth[:provider], uid: auth[:uid])
    Student::User.create_with_omniauth(auth) if user.blank?
  end
end
