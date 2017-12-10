class Student::BaseController < ApplicationController
  before_action :authenticate_student

  helper_method :current_student

  private

  def current_student
    @current_user ||= Student.find(session[:user_id]) if session[:user_id]
  end

  def authenticate_student
    redirect_to root_url, alert: 'ログインしてください' unless current_student
  end
end
