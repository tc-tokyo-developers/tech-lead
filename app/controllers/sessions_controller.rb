class SessionsController < ApplicationController
  def callback
    case session[:request_type]
    when 'mentor'
      create_or_login_mentor
    when 'student'
      create_or_login_student
    else
      # TODO: エラーをハンドリングする(クッキー切れ)
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
    add_mentor_id_to_cookies(mentor)
  end

  def create_or_login_student
    student = Student.find_from_auth_hash(auth_hash)
    if student.present?
      redirect_to root_url, notice: 'ログインしました'
    else
      student = Student.create_with_omniauth(auth_hash)
      redirect_to edit_student_account_path, notice: 'ユーザー情報を登録してください'
    end
    add_student_id_to_cookies(student)
  end

  def auth_hash
    request.env['omniauth.auth']
  end

  def add_mentor_id_to_cookies(mentor)
    cookies.delete(:student_id)
    cookies.permanent.signed[:mentor_id] = {
      value: mentor.id,
      expires: 30.days.from_now
    }
  end

  def add_student_id_to_cookies(student)
    cookies.delete(:mentor_id)
    cookies.permanent.signed[:student_id] = {
      value: student.id,
      expires: 30.days.from_now
    }
  end
end
