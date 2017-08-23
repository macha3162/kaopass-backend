class SessionSerializer < ActiveModel::Serializer
  attributes :id, :time, :place, :title, :detail, :number
end
