# == Schema Information
#
# Table name: messages
#
#  id            :integer          not null, primary key
#  content       :text(65535)
#  chat_group_id :integer          not null
#  user_id       :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_messages_on_chat_group_id  (chat_group_id)
#  index_messages_on_user_id        (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (chat_group_id => users.id)
#  fk_rails_...  (user_id => users.id)
#

require 'rails_helper'

RSpec.describe Message, type: :model do
  let(:user)       { create(:user) }
  let(:chat_group) { create(:chat_group) }
  let(:content)    { 'test_message' }
  let(:message)    { build(:message, content: content, user: user, chat_group: chat_group) }
  before(:each) do
    create(:type, name: 'student')
    create(:type, name: 'mentor')
  end

  context 'when correct attributes' do
    it { expect(message).to be_valid }
  end
  context 'when incorrect attributes' do
    context 'when blank user' do
      let(:user) { nil }
      it { expect(message).to be_invalid }
    end
    context 'when blank chat_group' do
      let(:chat_group) { nil }
      it { expect(message).to be_invalid }
    end
    context 'when blank content' do
      let(:content) { nil }
      it { expect(message).to be_invalid }
    end
  end
end
