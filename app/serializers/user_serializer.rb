class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :visit_count, :session_ids
  has_many :photos
  has_many :signatures

  def visit_count
    object.visit_histories.count if object.present?
  end

  def session_ids
    object.sessions.pluck(:number)
  end
end
