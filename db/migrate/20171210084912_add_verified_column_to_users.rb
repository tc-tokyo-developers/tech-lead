class AddVerifiedColumnToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :verified, :bool, null: false, default: false, after: :profile
  end
end
