require 'rails_helper'

RSpec.describe Mentor::SessionsController, type: :controller do
  before do
    create(:type, name: 'student')
    create(:type, name: 'mentor')
  end

  describe '#destroy' do
    let(:mentor) { build(:mentor) }
    before(:each) do
      cookies.permanent.signed[:mentor_id] = {
        value: mentor.id,
        expires: 30.days.from_now
      }
      get :destroy
    end

    it 'resets cookies' do
      expect(cookies.signed[:mentor_id]).to eq nil
    end
    it 'redirects to mentor_root_url' do
      expect(response).to redirect_to mentor_root_url
    end
    it 'show the notice flash' do
      expect(flash[:notice]).to eq 'ログアウトしました'
    end
  end
end
