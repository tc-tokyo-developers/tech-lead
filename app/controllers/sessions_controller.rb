class SessionsController < ApplicationController
  def callback
    case session[:request_type]
    when 'mentor'
      create_or_login_mentor
    when 'student'
      create_or_login_student
    else
      # TODO: エラーをハンドリングする(セッション切れ)
      raise
    end
  end

  private

  def create_or_login_mentor
    mentor = Mentor.find_from_auth_hash(auth_hash)
    if mentor.present?
      redirect_to mentor_root_url, notice: 'ログインしました'
    else
      mentor = Mentor.create_with_omniauth(auth_hash)
      redirect_to edit_mentor_account_path, notice: 'ユーザー情報を登録してください'
    end
    session[:mentor_id] = mentor.id
  end

  def create_or_login_student
    student = Student.find_from_auth_hash(auth_hash)
    if student.present?
      redirect_to root_url, notice: 'ログインしました'
    else
      student = Student.create_with_omniauth(auth_hash)
      redirect_to edit_student_account_path, notice: 'ユーザー情報を登録してください'
    end
    session[:student_id] = student.id
  end

  def auth_hash
    request.env['omniauth.auth']
  end
end
