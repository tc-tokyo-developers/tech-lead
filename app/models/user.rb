class User < ApplicationRecord
  enum type_id: { student: 1, mentor: 2 }

  validates :type_id, :provider, :uid, :github_name, presence: true
  validates :verified, inclusion: { in: [true, false] }

  scope :find_from_auth_hash, lambda { |auth_hash|
    find_by(provider: auth_hash[:provider], uid: auth_hash[:uid])
  }

  def username
    nickname? ? nickname : github_name
  end
end
