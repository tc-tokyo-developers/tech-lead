require 'rails_helper'

RSpec.describe Student::AccountsController, type: :controller do
  let!(:type) { create(:type, name: 'student') }
  let(:user) { create(:user, type_id: :student) }
  before(:each) { session[:user_id] = user.id }

  describe '#show' do
    before(:each) { get :show }

    it 'assigns current_user to @user' do
      expect(assigns(:user)).to eq user
    end
    it 'renders the :show template' do
      expect(response).to render_template :show
    end
  end

  describe '#edit' do
    before(:each) { get :edit }

    it 'assigns current_user to @user' do
      expect(assigns(:user)).to eq user
    end
    it 'renders the :edit template' do
      expect(response).to render_template :edit
    end
  end

  describe '#update' do
    context 'when update success' do
      let(:nickname)    { Faker::Internet.user_name }
      let(:profile)     { Faker::Lorem.sentence }
      let(:user_params) { { user: { nickname: nickname, profile: profile } } }
      before(:each) { patch :update, params: user_params }

      it 'redirects to student_accounts_path' do
        expect(response).to redirect_to student_accounts_path
      end
      it 'shows the notice flash' do
        expect(flash[:notice]).to eq 'ユーザー情報の更新に成功しました'
      end
      it 'changes nickname' do
        user.reload
        expect(user.nickname).to eq nickname
      end
      it 'changes profile' do
        user.reload
        expect(user.profile).to eq profile
      end
    end
  end
end
