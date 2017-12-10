class Student::SessionsController < Student::BaseController
  skip_before_action :authenticate_student

  def destroy
    reset_session
    redirect_to root_url, notice: 'ログアウトしました'
  end
end
