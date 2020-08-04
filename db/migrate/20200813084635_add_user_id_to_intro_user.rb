class AddUserIdToIntroUser < ActiveRecord::Migration[5.2]
  def change
    add_column :intro_users, :user_id, :integer
  end
end
