class Photo < ApplicationRecord
  belongs_to :user
  has_many :faces, dependent: :destroy
  mount_uploader :image, ImageUploader


  def save_faces
    self.faces.destroy_all
    detected_faces = detects_faces
    detected_faces.each do |face_record|
      if face_record.face.present?
        new_face = self.faces.new
        new_face.set_face(face_record.face)
        new_face.save
      end
    end
    self.faces
  end

  def detects_faces
    $rekognition.index_faces(
        {
            collection_id: Rails.application.secrets.aws[:collection_id],
            detection_attributes: [],
            external_image_id: self.id.to_s,
            image: {
                s3_object: {
                    bucket: Rails.application.secrets.aws[:bucket],
                    name: self.image.path,
                },
            },
        }).face_records
  end
end
