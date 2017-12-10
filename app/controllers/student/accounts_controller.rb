class Student::AccountsController < ApplicationController
  before_action :set_current_user

  def show; end

  def edit; end

  def update
    @user.update!(user_params)
    redirect_to student_account_path, notice: 'ユーザー情報の更新に成功しました'
  end

  private

  def set_current_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:nickname, :profile)
  end
end
