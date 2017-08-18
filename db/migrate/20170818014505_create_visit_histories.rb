class CreateVisitHistories < ActiveRecord::Migration[5.1]
  def change
    create_table :visit_histories do |t|
      t.integer :user_id

      t.timestamps
    end

    add_index :visit_histories, :user_id
  end
end
