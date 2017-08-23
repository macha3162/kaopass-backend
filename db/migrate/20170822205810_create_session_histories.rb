class CreateSessionHistories < ActiveRecord::Migration[5.1]
  def change
    create_table :session_histories do |t|
      t.integer :session_id
      t.integer :user_id

      t.timestamps
    end
  end
end
