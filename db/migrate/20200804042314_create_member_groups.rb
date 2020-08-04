class CreateMemberGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :member_groups do |t|
      t.references :user, foreign_key: true
      t.references :group, foreign_key: true
      t.integer :status

      t.timestamps
    end
  end
end
