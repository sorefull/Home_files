class AddPublicToContent < ActiveRecord::Migration[5.0]
  def change
    add_column :contents, :public, :boolean, default: false
  end
end
