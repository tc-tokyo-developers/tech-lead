# == Schema Information
#
# Table name: types
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Type, type: :model do
  describe 'validation' do
    context 'valid' do
      it 'is valid with name' do
        expect(build(:type)).to be_valid
      end
    end

    context 'invalid' do
      it 'is invalid without name' do
        expect(build(:type, name: nil)).not_to be_valid
      end
    end
  end
end
