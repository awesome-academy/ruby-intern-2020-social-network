class CreateFriendRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :friend_requests do |t|
      t.integer :requestor_id
      t.integer :receiver_id
      t.integer :status

      t.timestamps
    end
    add_index :friend_requests, :requestor_id
    add_index :friend_requests, :receiver_id
    add_index :friend_requests, [:requestor_id, :receiver_id], unique:true
  end
end
