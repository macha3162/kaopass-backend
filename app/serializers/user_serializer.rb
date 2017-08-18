class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :visit_count
  has_many :photos
  has_many :signatures

  def visit_count
    object.visit_histories.count if object.present?
  end
end
