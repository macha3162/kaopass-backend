class Signature < ApplicationRecord
  belongs_to :user
  mount_base64_uploader :image, ImageUploader

  attribute :uuid, :string, default: -> { SecureRandom.uuid }

  after_save :save_name

  def save_name
    user.update_attribute(:name, name) if user.present?
  end
end
