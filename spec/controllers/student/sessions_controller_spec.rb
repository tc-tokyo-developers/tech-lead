require 'rails_helper'
# TODO: student/sessions_controllerではなくsessions_controllerが読み込まれる問題を解決したら外す
require 'student/sessions_controller'

RSpec.describe Student::SessionsController, type: :controller do
  before { create(:type, name: 'student') }

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
