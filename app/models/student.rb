class Student < User
  scope :find_from_auth_hash, lambda { |auth_hash|
    find_by(provider: auth_hash[:provider], uid: auth_hash[:uid])
  }

  def self.create_with_omniauth(auth_hash)
    # TODO: エラーをハンドリングする
    create! do |user|
      user.type_id     = :student
      user.provider    = auth_hash[:provider]
      user.uid         = auth_hash[:uid]
      user.github_name = auth_hash[:info][:nickname]
    end
  end
end
