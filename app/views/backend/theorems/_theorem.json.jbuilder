json.extract! theorem, :id, :connector, :claim_id, :claim_value, :created_at, :updated_at
json.url theorem_url(theorem, format: :json)
json.consequences theorem.consequences do |consequence|
  json.extract! consequence, :id, :connector, :claim_id, :claim_value, :created_at, :updated_at
  json.url theorem_url(consequence, format: :json)
end 
json.reasons theorem.reasons do |reason|
  json.extract! reason, :id, :connector, :claim_id, :claim_value, :created_at, :updated_at
  json.url theorem_url(reason, format: :json)
end 