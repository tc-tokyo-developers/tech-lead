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

require 'rails_helper'

RSpec.describe Knowledge, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
