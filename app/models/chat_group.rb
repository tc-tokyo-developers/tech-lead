# == Schema Information
#
# Table name: chat_groups
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ChatGroup < ApplicationRecord
  has_many :messages
end
