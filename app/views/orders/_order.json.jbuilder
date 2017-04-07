json.extract! order, :id, :period,:frequency, :start_date, :address, :phone, :created_at, :updated_at
json.url order_url(order, format: :json)
