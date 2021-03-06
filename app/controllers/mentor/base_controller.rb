class Mentor::BaseController < ApplicationController
  before_action :authenticate_mentor, :set_request_type_session

  helper_method :current_mentor

  private

  def current_mentor
    mentor_id = cookies.signed[:mentor_id]
    return if mentor_id.blank?
    @current_mentor ||= Mentor.find(mentor_id)
  end

  def authenticate_mentor
    if !current_mentor
      redirect_to mentor_root_url, alert: 'ログインしてください'
    elsif !current_mentor.verified
      redirect_to mentor_root_url, alert: 'アカウントが認証されていません'
    end
  end

  def set_request_type_session
    session['request_type'] = 'mentor'
  end
end
