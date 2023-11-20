json.extract! list_tour, :id, :name, :category_id, :created_at, :updated_at
json.url list_tour_url(list_tour, format: :json)
