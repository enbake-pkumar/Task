json.array!(@payments) do |payment|
  json.extract! payment, :id, :line_item_id, :service_id
  json.url payment_url(payment, format: :json)
end
