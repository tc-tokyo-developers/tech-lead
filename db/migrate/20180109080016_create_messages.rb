class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.text         :content
      t.references   :chat_group, foreign_key: { to_table: :users },
                                  null: false
      t.references   :user, foreign_key: true, null: false
      t.timestamps null: false
    end
  end
end
