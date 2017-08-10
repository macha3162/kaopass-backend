class User < ApplicationRecord

  has_many :photos, dependent: :destroy
  has_many :signatures, dependent: :destroy
end
