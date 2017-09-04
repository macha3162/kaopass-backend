include ActionView::Helpers::TextHelper
class SessionSerializer < ActiveModel::Serializer
  attributes :id, :time, :place, :title, :detail, :number, :short_title

  def short_title
      truncate(object.title, length: 10)
  end
end
