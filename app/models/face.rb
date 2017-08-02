class Face < ApplicationRecord
  belongs_to :photo

  before_destroy :delete_face_collection

  def set_face(face)
    if face.present?
      self.attributes = {
          width: face.bounding_box.width,
          height: face.bounding_box.height,
          left: face.bounding_box.left,
          top: face.bounding_box.top,
          aws_image_id: face.image_id,
          aws_face_id: face.face_id,
          confidence: face.confidence
      }
    end
  end

  def self.find_by_image(image)
    $rekognition.search_faces_by_image(
        {
            collection_id: Settings.aws.collection_id,
            face_match_threshold: 95,
            image: {
                bytes: image.read
            },
        })
  end

  def self.find_by_s3(path)
    $rekognition.search_faces_by_image(
        {
            collection_id: Settings.aws.collection_id,
            face_match_threshold: 60,
            image: {
                s3_object: {
                    bucket: Settings.aws.bucket,
                    name: path,
                },
            },
        })
  end

  def delete_face_collection
    $rekognition.delete_faces(
        {
            collection_id: Settings.aws.collection_id,
            face_ids: [self.aws_face_id],
        })
  end
end