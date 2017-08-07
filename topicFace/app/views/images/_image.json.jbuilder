json.extract! image, :id, :tittle, :description, :private, :filesize, :created_at, :updated_at
json.url image_url(image, format: :json)
