class AddHasFaceToPhotos < ActiveRecord::Migration[5.1]
  def change
    add_column :photos, :has_face, :boolean, default: false
  end
end
