require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  include OmniAuthHelper

  describe '#callback' do
    let(:uid)      { 1_234_567_890 }
    let(:nickname) { 'hoge' }
    before(:each) do
      create(:type, name: 'student')
      create(:type, name: 'mentor')
      OmniAuth.config.mock_auth[:github] = nil
      request.env['omniauth.auth'] = github_mock(uid, nickname)
    end
    subject { get :callback, params: { provider: 'github' } }

    context 'when session[:request_type] is student' do
      before(:each) { session[:request_type] = 'student' }

      context 'when requested user has not registered' do
        it 'increases the number of users' do
          expect { subject }.to change(Student, :count).by 1
        end
        it 'assigns the requested user id to session[:student_id]' do
          subject
          new_student = Student.find_by(uid: uid)
          expect(session[:student_id]).to eq new_student.id
        end
        it 'redirects to edit_student_account_path' do
          subject
          expect(response).to redirect_to edit_student_account_path
        end
        it 'shows the notice flash' do
          subject
          expect(flash[:notice]).to eq 'ユーザー情報を登録してください'
        end
      end

      context 'when requested student has already registered' do
        let!(:student) { create(:student, uid: uid, nickname: nickname) }
        before(:each) { subject }

        it 'assigns the requested student id to session[:student_id]' do
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

    context 'when session[:request_type] is mentor' do
      before(:each) { session[:request_type] = 'mentor' }

      context 'when requested mentor has not registered' do
        it 'increases the number of mentors' do
          expect { subject }.to change(Mentor, :count).by 1
        end
        it 'assigns the requested mentor id to session[:mentor_id]' do
          subject
          new_mentor = Mentor.find_by(uid: uid)
          expect(session[:mentor_id]).to eq new_mentor.id
        end
        it 'redirects to edit_mentor_accounts_path' do
          subject
          expect(response).to redirect_to edit_mentor_account_path
        end
        it 'shows the notice flash' do
          subject
          expect(flash[:notice]).to eq 'ユーザー情報を登録してください'
        end
      end

      context 'when requested mentor has already registered' do
        let!(:mentor) { create(:mentor, uid: uid, nickname: nickname) }
        before(:each) { subject }

        it 'assigns the requested mentor id to session[:mentor_id]' do
          expect(session[:mentor_id]).to eq mentor.id
        end
        it 'redirects to mentor_root_url' do
          expect(response).to redirect_to mentor_root_url
        end
        it 'shows the notice flash' do
          expect(flash[:notice]).to eq 'ログインしました'
        end
      end
    end

    context 'when session[:request_type] is not student or mentor' do
      # TODO: 実装したら修正
      it 'raises' do
        expect { subject }.to raise_error StandardError
      end
    end
  end
end
