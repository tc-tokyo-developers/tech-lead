class Mentor::SessionsController < Mentor::BaseController
  skip_before_action :authenticate_mentor

  def destroy
    reset_session
    redirect_to mentor_root_url, notice: 'ログアウトしました'
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
end
