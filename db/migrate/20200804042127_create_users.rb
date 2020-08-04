class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :remember_digest
      t.string :reset_digest
      t.datetime :reset_send_at
      t.integer :admin
      t.string :avatar
      t.string :image_background
      t.integer :intro_user_id

      t.timestamps
    end
  end
end
