require 'rails_helper'

RSpec.describe Mentor::AccountsController, type: :controller do
  let(:mentor) { create(:mentor) }
  before(:each) do
    create(:type, name: 'student')
    create(:type, name: 'mentor')
    session[:mentor_id] = mentor.id
  end

  # before_actionは全てのアクションでテストする必要ないと判断
  context 'when mentor does not login' do
    before(:each) do
      session[:mentor_id] = nil
      get :show
    end

    it 'redirects to mentor_root_path' do
      expect(response).to redirect_to mentor_root_path
    end
    it 'shows the alert flash' do
      expect(flash[:alert]).to eq 'ログインしてください'
    end
  end

  context 'when mentor is not verified' do
    before(:each) { get :show }

    it 'redirects to mentor_root_path' do
      expect(response).to redirect_to mentor_root_path
    end
    it 'shows the alert flash' do
      expect(flash[:alert]).to eq 'アカウントが認証されていません'
    end
  end

  context 'when mentor is valid' do
    before(:each) { mentor.update!(verified: true) }

    describe '#show' do
      before(:each) { get :show }

      it 'assigns current_mentor to @mentor' do
        expect(assigns(:mentor)).to eq mentor
      end
      it 'renders the :show template' do
        expect(response).to render_template :show
      end
    end

    describe '#edit' do
      before(:each) { get :edit }

      it 'assigns current_mentor to @mentor' do
        expect(assigns(:mentor)).to eq mentor
      end
      it 'renders the :edit template' do
        expect(response).to render_template :edit
      end
    end

    describe '#update' do
      context 'when update success' do
        let(:nickname)    { Faker::Internet.user_name }
        let(:profile)     { Faker::Lorem.sentence }
        let(:mentor_params) { { mentor: { nickname: nickname, profile: profile } } }
        before(:each) { patch :update, params: mentor_params }

        it 'redirects to mentor_accounts_path' do
          expect(response).to redirect_to mentor_account_path
        end
        it 'shows the notice flash' do
          expect(flash[:notice]).to eq 'ユーザー情報の更新に成功しました'
        end
        it 'changes nickname' do
          mentor.reload
          expect(mentor.nickname).to eq nickname
        end
        it 'changes profile' do
          mentor.reload
          expect(mentor.profile).to eq profile
        end
      end
    end
  end
end
