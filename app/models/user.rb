class User < ApplicationRecord
  enum type_id: { student: 1, mentor: 2 }
end
