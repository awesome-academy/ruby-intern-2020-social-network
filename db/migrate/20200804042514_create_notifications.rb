class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.references :user, foreign_key: true
      t.integer :notified_by_id
      t.string :notice_type
      t.integer :notificationable_id
      t.string :notificationable_type
      t.boolean :read
      t.boolean :checker

      t.timestamps
    end
  end
end
