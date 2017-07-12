json.extract! request, :id, :title, :content, :created_at, :updated_at
json.url request_url(request, format: :json)
