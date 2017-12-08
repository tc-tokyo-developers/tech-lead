class Student::AccountsController < ApplicationController
  before_action :set_current_user

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to root_url, notice: 'ユーザー情報の更新に成功しました'
    else
      flash.now.alert = 'ユーザー情報の更新に失敗しました'
      render :edit
    end
  end

  private

  def set_current_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:nickname, :profile)
  end
end
