class CreateSessions < ActiveRecord::Migration[5.1]
  def change
    create_table :sessions do |t|
      t.string :time
      t.string :place
      t.string :title
      t.string :short_title
      t.string :detail
      t.integer :number

      t.timestamps
    end
  end
end
