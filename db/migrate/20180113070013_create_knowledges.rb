class CreateKnowledges < ActiveRecord::Migration[5.0]
  def change
    create_table :knowledges do |t|
<<<<<<< HEAD
<<<<<<< HEAD
      t.string :title, null: false
      t.text :content, null: false
      t.references :user, foreign_key: true
=======

>>>>>>> 893e1df... knowledge model を生成
=======
      t.string :title, null: false
      t.text :content, null: false
      t.references :user, foreign_key: true
>>>>>>> b7c9076... dbを作った
      t.timestamps
    end
  end
end
