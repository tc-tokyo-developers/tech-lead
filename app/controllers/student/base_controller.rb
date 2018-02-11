class Student::BaseController < ApplicationController
  before_action :authenticate_student, :set_request_type_session

  helper_method :current_student

  private

  def current_student
    student_id = cookies.signed[:student_id]
    return if student_id.blank?
    @current_student ||= Student.find(student_id)
  end

  def authenticate_student
    redirect_to root_url, alert: 'ログインしてください' unless current_student
  end

  def set_request_type_session
    session['request_type'] = 'student'
  end
end
