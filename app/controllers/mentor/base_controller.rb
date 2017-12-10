class Mentor::BaseController < ApplicationController
  before_action :authenticate_mentor, :set_request_type_session

  helper_method :current_mentor

  private

  def current_mentor
    @current_mentor ||= Mentor.find(session[:mentor_id]) if session[:mentor_id]
  end

  def authenticate_mentor
    if !verified
      redirect_to root_url, alert: 'アカウントが認証されていません'
    elsif !current_mentor
      redirect_to root_url, alert: 'ログインしてください'
    end
  end

  def set_request_type_session
    session['request_type'] = 'mentor'
  end
end
