# == Schema Information
#
# Table name: users
#
#  id          :integer          not null, primary key
#  type_id     :integer          not null
#  provider    :string(255)      not null
#  uid         :string(255)      not null
#  github_name :string(255)      not null
#  nickname    :string(255)
#  profile     :text(65535)
#  verified    :boolean          default(FALSE), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_users_on_type_id  (type_id)
#
# Foreign Keys
#
#  fk_rails_...  (type_id => types.id)
#

class ChatGroup < Student
  has_many :messages, dependent: :destroy

  class << self
    def all_with_latest_message
      find_by_sql(
        <<-SQL
          SELECT id, nickname,
            #{latest_message_sql('content')} AS latest_message,
            #{latest_message_sql('created_at')} AS updated_time
          FROM users
          WHERE type_id = #{type_ids[:student]}
          ORDER BY updated_time DESC
        SQL
      )
    end

    private

    def latest_message_sql(column)
      <<-SQL
        (
          SELECT #{column} FROM messages
          WHERE users.id = messages.chat_group_id
          ORDER BY created_at DESC
          LIMIT 1
        )
      SQL
    end
  end
end
