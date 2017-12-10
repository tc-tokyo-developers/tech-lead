class Student < User
  scope :find_from_auth_hash, lambda { |auth_hash|
    find_by(provider: auth_hash[:provider], uid: auth_hash[:uid])
  }

  before_validation do
    self.type_id = :student
    self.verified = true
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
