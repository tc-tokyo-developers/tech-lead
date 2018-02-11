# == Schema Information
#
# Table name: users
#
#  id          :integer          not null, primary key
#  type_id     :integer          not null
#  provider    :string(255)      not null
#  uid         :string(255)      not null
#  github_name :string(255)      not null
#  nickname    :string(255)
#  profile     :text(65535)
#  verified    :boolean          default(FALSE), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_users_on_type_id  (type_id)
#
# Foreign Keys
#
#  fk_rails_...  (type_id => types.id)
#

require 'rails_helper'

RSpec.describe ChatGroup, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
