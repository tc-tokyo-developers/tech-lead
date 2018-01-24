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

class User < ApplicationRecord
  has_many :messages, dependent: :destroy
  enum type_id: { student: 1, mentor: 2 }

  validates :type_id, :provider, :uid, :github_name, presence: true
  validates :verified, inclusion: { in: [true, false] }

  def username
    nickname? ? nickname : github_name
  end
end
