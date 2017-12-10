class Student::BaseController < ApplicationController
  before_action :authenticate_student

  helper_method :current_student

  private

  def current_student
    @current_student ||= Student.find(session[:student_id]) if session[:student_id]
  end

  def authenticate_student
    redirect_to root_url, alert: 'ログインしてください' unless current_student
  end
end
