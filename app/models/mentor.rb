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

class Mentor < User
  default_scope -> { where(type_id: :mentor) }

  before_validation { self.type_id = :mentor }

  def self.find_from_auth_hash(auth_hash)
    find_by(type_id: :mentor,
            provider: auth_hash[:provider],
            uid: auth_hash[:uid])
  end

  def self.create_with_omniauth(auth_hash)
    # TODO: エラーをハンドリングする
    create! do |mentor|
      mentor.provider    = auth_hash[:provider]
      mentor.uid         = auth_hash[:uid]
      mentor.github_name = auth_hash[:info][:nickname]
    end
  end
end
