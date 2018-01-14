class ChangeConstraintUserIdOfKnowledges < ActiveRecord::Migration[5.0]
  def change
    change_column_null :knowledges, :user_id, false
  end
end
