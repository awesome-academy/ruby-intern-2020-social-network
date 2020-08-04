class CreateGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :groups do |t|
      t.references :user, foreign_key: true
      t.string :avatar
      t.string :image_background
      t.string :intro_group

      t.timestamps
    end
  end
end
