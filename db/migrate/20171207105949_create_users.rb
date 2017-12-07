class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.references :type, null: false, foreign_key: true
      t.string     :provider, null: false
      t.string     :uid, null: false
      t.string     :github_name, null: false
      t.string     :nickname
      t.text       :profile
      t.timestamps null: false
    end
  end
end
