# == Schema Information
#
# Table name: knowledges
#
#  id      :integer          not null, primary key
#  title   :string(255)      not null
#  content :text(65535)      not null
#  user_id :integer          not null
#
# Indexes
#
#  index_knowledges_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class Knowledge < ApplicationRecord
  validates :id, presence: true, uniqueness: true
  validates :title, presence: true
  validates :content, presence: true
  validates :user_id, presence: true
end
