class Student::SessionsController < ApplicationController
  def callback
    auth = request.env['omniauth.auth']
    user = User.find_by(provider: auth[:provider], uid: auth[:uid])
    user = User.create_with_omniauth(auth) if user.empty?
    session[:user_id] = user.id
    redirect_to root_url
  end

  def destroy
    reest_session
    redirect_to root_url
  end
end
