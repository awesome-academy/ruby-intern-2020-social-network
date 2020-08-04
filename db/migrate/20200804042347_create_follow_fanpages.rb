class CreateFollowFanpages < ActiveRecord::Migration[5.2]
  def change
    create_table :follow_fanpages do |t|
      t.references :user, foreign_key: true
      t.references :fanpage, foreign_key: true
      t.integer :status

      t.timestamps
    end
  end
end
