class Mentor < User
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
