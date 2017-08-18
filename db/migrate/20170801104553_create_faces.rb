class CreateFaces < ActiveRecord::Migration[5.1]
  def change
    create_table :faces do |t|
      t.integer :photo_id
      t.float :width
      t.float :height
      t.float :left
      t.float :top
      t.string :aws_image_id
      t.string :aws_face_id
      t.float :confidence

      t.timestamps
    end
    add_index :faces, :photo_id
  end
end
