json.extract! session, :id, :time, :place, :title, :detail, :number, :created_at, :updated_at
json.url session_url(session, format: :json)
