class CreateContents < ActiveRecord::Migration[5.0]
  def change
    create_table :contents do |t|
      t.string :content
      t.references :folder, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
