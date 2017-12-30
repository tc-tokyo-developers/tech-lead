require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) { create(:type, name: 'student') }

  describe 'validation' do
    context 'valid' do
      it 'is valid with nickname, profile' do
        expect(build(:user, type_id: :student)).to be_valid
      end
    end

    context 'invalid' do
      it 'is invalid without type_id' do
        expect(build(:user, type_id: nil)).not_to be_valid
      end

      it 'is invalid without provider' do
        expect(build(:user, type_id: :student, provider: nil)).not_to be_valid
      end

      it 'is invalid without uid' do
        expect(build(:user, type_id: :student, uid: nil)).not_to be_valid
      end

      it 'is invalid without github_name' do
        expect(build(:user, type_id: :student, github_name: nil)).not_to be_valid
      end
    end
  end
end
