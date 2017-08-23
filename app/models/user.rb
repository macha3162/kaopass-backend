class User < ApplicationRecord

  has_many :photos, dependent: :destroy
  has_many :signatures, dependent: :destroy
  has_many :visit_histories, dependent: :destroy
  has_many :session_histories, dependent: :destroy

  after_create :visit

  def visit
    self.visit_histories.create
  end
end
