class AddIntroUserIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :intro_user_id, :integer
  end
end
