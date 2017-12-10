class User < ApplicationRecord
  enum type_id: { student: 1, mentor: 2 }

  validates :type_id, :provider, :uid, :github_name, :verified, presence: true

  def username
    nickname? ? nickname : github_name
  end
end
