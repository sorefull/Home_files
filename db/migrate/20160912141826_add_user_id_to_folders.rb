class AddUserIdToFolders < ActiveRecord::Migration[5.0]
  def change
    add_column :folders, :user_id, :integer
  end
end
