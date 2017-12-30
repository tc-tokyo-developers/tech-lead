require 'rails_helper'

RSpec.describe Student::AccountsController, type: :controller do
  let!(:type) { create(:type, name: 'student') }
  let(:student) { create(:student) }
  before(:each) { session[:student_id] = student.id }

  # before_actionは全てのアクションでテストする必要ないと判断
  context 'when mentor does not login' do
    before(:each) do
      session[:student_id] = nil
      get :show
    end

    it 'redirects to root_path' do
      expect(response).to redirect_to root_path
    end
    it 'shows the alert flash' do
      expect(flash[:alert]).to eq 'ログインしてください'
    end
  end

  context 'when student login' do
    describe '#show' do
      before(:each) { get :show }

      it 'assigns current_student to @student' do
        expect(assigns(:student)).to eq student
      end
      it 'renders the :show template' do
        expect(response).to render_template :show
      end
    end

    describe '#edit' do
      before(:each) { get :edit }

      it 'assigns current_student to @student' do
        expect(assigns(:student)).to eq student
      end
      it 'renders the :edit template' do
        expect(response).to render_template :edit
      end
    end

    describe '#update' do
      context 'when update success' do
        let(:nickname)    { Faker::Internet.user_name }
        let(:profile)     { Faker::Lorem.sentence }
        let(:student_params) { { student: { nickname: nickname, profile: profile } } }
        before(:each) { patch :update, params: student_params }

        it 'redirects to student_accounts_path' do
          expect(response).to redirect_to student_account_path
        end
        it 'shows the notice flash' do
          expect(flash[:notice]).to eq 'ユーザー情報の更新に成功しました'
        end
        it 'changes nickname' do
          student.reload
          expect(student.nickname).to eq nickname
        end
        it 'changes profile' do
          student.reload
          expect(student.profile).to eq profile
        end
      end
    end
  end
end
