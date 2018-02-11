class Mentor::SessionsController < Mentor::BaseController
  skip_before_action :authenticate_mentor

  def destroy
    cookies.delete(:student_id)
    redirect_to mentor_root_url, notice: 'ログアウトしました'
  end
end
