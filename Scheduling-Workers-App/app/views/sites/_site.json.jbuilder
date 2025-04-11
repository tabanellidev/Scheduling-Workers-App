json.extract! site, :id, :nome, :time_required, :location, :requests, :owner, :created_at, :updated_at
json.url site_url(site, format: :json)
