class Mentor < User
  before_validation { self.type_id = :mentor }

  def self.create_with_omniauth(auth_hash)
    # TODO: エラーをハンドリングする
    create! do |mentor|
      mentor.provider    = auth_hash[:provider]
      mentor.uid         = auth_hash[:uid]
      menrot.github_name = auth_hash[:info][:nickname]
    end
  end
end
