class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.text         :content
      t.references   :chat_group, foreign_key: true
      t.references   :user, null: false
      t.timestamps
    end
  end
end
