class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.references :user, foreign_key: true
      t.references :group, foreign_key: true
      t.references :fanpage, foreign_key: true
      t.string :images
      t.string :content
      t.integer :private
      t.boolean :wait_approved

      t.timestamps
    end
  end
end
