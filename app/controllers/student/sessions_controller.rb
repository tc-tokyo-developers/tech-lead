class Student::SessionsController < Student::BaseController
  skip_before_action :authenticate_student

  def destroy
    cookies.delete(:student_id)
    redirect_to root_url, notice: 'ログアウトしました'
  end
end
