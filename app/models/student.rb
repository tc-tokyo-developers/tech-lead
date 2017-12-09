class Student < User
  scope :find_from_auth_hash, lambda { |auth_hash|
    find_by(provider: auth_hash[:provider], uid: auth_hash[:uid])
  }

  def self.create_with_omniauth(auth)
    # TODO: エラーをハンドリングする
    create! do |user|
      user.type_id     = :student
      user.provider    = auth[:provider]
      user.uid         = auth[:uid]
      user.github_name = auth[:info][:nickname]
    end
  end
end
