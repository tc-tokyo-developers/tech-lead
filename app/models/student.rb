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

class Student < User
  before_validation do
    self.type_id = :student
    self.verified = true
  end

  def self.find_from_auth_hash(auth_hash)
    find_by(type_id: :student,
            provider: auth_hash[:provider],
            uid: auth_hash[:uid])
  end

  def self.create_with_omniauth(auth_hash)
    # TODO: エラーをハンドリングする
    create! do |student|
      student.provider    = auth_hash[:provider]
      student.uid         = auth_hash[:uid]
      student.github_name = auth_hash[:info][:nickname]
    end
  end
end
