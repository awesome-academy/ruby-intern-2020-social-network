class CreateIntroUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :intro_users do |t|
      t.integer :gender
      t.date :birth_day
      t.integer :marital_status
      t.string :address
      t.string :job
      t.string :school

      t.timestamps
    end
  end
end
