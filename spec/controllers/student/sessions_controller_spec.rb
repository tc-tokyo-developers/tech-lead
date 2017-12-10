require 'rails_helper'

RSpec.describe Student::SessionsController, type: :controller do
  include OmniAuthHelper

  before { create(:type, name: 'student') }

  describe '#callback' do
    let(:uid)      { 1_234_567_890 }
    let(:nickname) { 'hoge' }
    before(:each) do
      OmniAuth.config.mock_auth[:github] = nil
      request.env['omniauth.auth'] = github_mock(uid, nickname)
    end
    subject { get :callback, params: { provider: 'github' } }

    context 'when requested user has not registered' do
      it 'increases the number of users' do
        expect { subject }.to change(Student, :count).by 1
      end
      it 'assigns the requested user id to session[:user_id]' do
        subject
        new_student = Student.find_by(uid: uid)
        expect(session[:student_id]).to eq new_student.id
      end
      it 'redirects to edit_student_accounts_path' do
        subject
        expect(response).to redirect_to edit_student_account_path
      end
      it 'shows the notice flash' do
        subject
        expect(flash[:notice]).to eq 'ユーザー情報を登録してください'
      end
    end

    context 'when requested user has already registered' do
      let!(:student) { create(:student, uid: uid, nickname: nickname) }
      before(:each) { subject }

      it 'assigns the requested user id to session[:user_id]' do
        expect(session[:student_id]).to eq student.id
      end
      it 'redirects to root_url' do
        expect(response).to redirect_to root_url
      end
      it 'shows the notice flash' do
        expect(flash[:notice]).to eq 'ログインしました'
      end
    end
  end

  describe '#destroy' do
    let(:student) { build(:student) }
    before(:each) do
      session[:student_id] = student.id
      get :destroy
    end

    it 'resets sessions' do
      expect(session[:student_id]).to eq nil
    end
    it 'redirects to root_url' do
      expect(response).to redirect_to root_url
    end
    it 'show the notice flash' do
      expect(flash[:notice]).to eq 'ログアウトしました'
    end
  end
end
