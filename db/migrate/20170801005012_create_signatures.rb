class CreateSignatures < ActiveRecord::Migration[5.1]
  def change
    create_table :signatures do |t|
      t.integer :user_id
      t.string :image
      t.string :name
      t.timestamps
    end
    add_index :signatures, :user_id
  end
end
