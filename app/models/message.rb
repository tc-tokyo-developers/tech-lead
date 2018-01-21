# == Schema Information
#
# Table name: messages
#
#  id            :integer          not null, primary key
#  content       :text(65535)
#  chat_group_id :integer
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
#  fk_rails_...  (chat_group_id => chat_groups.id)
#

class Message < ApplicationRecord
  belongs_to :chat_group
  belongs_to :user
  
end
