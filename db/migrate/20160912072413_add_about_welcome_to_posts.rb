class AddAboutWelcomeAndAboutUserToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :about_welcome, :boolean, default: false
  end
end
