class Student::AccountsController < Student::BaseController
  before_action :set_current_student

  def show; end

  def edit; end

  def update
    @student.update!(student_params)
    redirect_to student_account_path, notice: 'ユーザー情報の更新に成功しました'
  end

  private

  def set_current_student
    @student = current_student
  end

  def user_params
    params.require(:user).permit(:nickname, :profile)
  end
end
