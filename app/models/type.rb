# == Schema Information
#
# Table name: types
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Type < ApplicationRecord
  validates :name, presence: true
end
