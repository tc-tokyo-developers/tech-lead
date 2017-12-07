class User < ApplicationRecord
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider    = auth[:provider]
      user.uid         = auth[:uid]
      user.github_name = auth[:info][:nickname]
    end
  end
end
