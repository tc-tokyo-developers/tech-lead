class Student::User < User
  def self.create_with_omniauth(auth)
    create! do |user|
      user.type_id     = :student
      user.provider    = auth[:provider]
      user.uid         = auth[:uid]
      user.github_name = auth[:info][:nickname]
    end
  end
end
