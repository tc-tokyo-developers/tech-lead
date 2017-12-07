class Student::AccountsController < ApplicationController
  def show
    # TODO: プロフィール表示画面を作成する
    redirect_to edit_edit_student_accounts_path
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to root_url, notice: 'ユーザー情報の更新に成功しました'
    else
      flash.now.alert = 'ユーザー情報の更新に失敗しました'
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :profile)
  end
end
