class AddUuidToPhoto < ActiveRecord::Migration[5.1]
  def change
    add_column :photos, :uuid, :string
    add_column :signatures, :uuid, :string
  end
end
