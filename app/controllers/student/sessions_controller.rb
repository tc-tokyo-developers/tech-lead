class Student::SessionsController < Student::BaseController
  skip_before_action :authenticate_student

  def callback
    student = Student.find_from_auth_hash(auth_hash)
    if student.present?
      redirect_to root_url, notice: 'ログインしました'
    else
      student = Student.create_with_omniauth(auth_hash)
      redirect_to edit_student_account_path, notice: 'ユーザー情報を登録してください'
    end
    session[:user_id] = student.id
  end

  def destroy
    reset_session
    redirect_to root_url, notice: 'ログアウトしました'
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
end
