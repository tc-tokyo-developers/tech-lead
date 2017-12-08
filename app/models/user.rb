class User < ApplicationRecord
  enum type_id: { student: 1, mentor: 2 }

  validates :type_id, :provider, :uid, :github_name, presence: true
end
