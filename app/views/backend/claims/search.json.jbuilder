i = 1000
json.array!(@claims) do |claim|
  json.merge! claim.attributes
  json.url claim_url(claim, format: :json)
  json.score i
  i -= 1
end