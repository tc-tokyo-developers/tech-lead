require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    create(:type, name: 'student')
    create(:type, name: 'mentor')
  end

  describe 'validation' do
    context 'valid' do
      it 'is valid with nickname, profile' do
        expect(build(:user)).to be_valid
      end
    end

    context 'invalid' do
      it 'is invalid without type_id' do
        expect(build(:user, type_id: nil)).not_to be_valid
      end
      it 'is invalid without provider' do
        expect(build(:user, provider: nil)).not_to be_valid
      end
      it 'is invalid without uid' do
        expect(build(:user, uid: nil)).not_to be_valid
      end
      it 'is invalid without github_name' do
        expect(build(:user, github_name: nil)).not_to be_valid
      end
    end
  end

  describe '#username' do
    it 'returns nickname when nickname is set' do
      nickname = 'hoge'
      user = build(:user, nickname: nickname)
      expect(user.username).to eq nickname
    end
    it 'returns github_name when nickname is empty' do
      user = build(:user)
      expect(user.username).to eq user.github_name
    end
  end
end
