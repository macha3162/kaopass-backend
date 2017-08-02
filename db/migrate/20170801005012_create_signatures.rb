class CreateSignatures < ActiveRecord::Migration[5.1]
  def change
    create_table :signatures do |t|
      t.integer :user_id
      t.string :image
      t.timestamps
    end
  end
end
