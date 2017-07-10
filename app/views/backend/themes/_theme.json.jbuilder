json.extract! theme, :id, :name, :created_at, :updated_at
json.arguments theme.arguments
json.url theme_url(theme, format: :json)