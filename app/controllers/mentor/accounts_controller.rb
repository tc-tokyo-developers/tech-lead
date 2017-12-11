class Mentor::AccountsController < Mentor::BaseController
  before_action :set_current_mentor

  def show; end

  def edit; end

  def update
    @mentor.update!(mentor_params)
    redirect_to mentor_account_path, notice: 'ユーザー情報の更新に成功しました'
  end

  private

  def set_current_mentor
    @mentor = current_mentor
  end

  def mentor_params
    params.require(:mentor).permit(:nickname, :profile)
  end
end
