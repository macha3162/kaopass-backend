class Search < ApplicationRecord

  attribute :uuid, :string, default: -> { SecureRandom.uuid }

  mount_uploader :image, ImageUploader

  # 画像保存用のダミー
  def user_id
    99999
  end
end
