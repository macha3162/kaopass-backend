class IndexFacesJob < ApplicationJob
  queue_as :default

  def perform(photo)
    photo.save_faces
  end
end
