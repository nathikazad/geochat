Apipie.configure do |config|
  config.app_name                = "Geochat"
  config.api_base_url            = "/api"
  config.doc_base_url            = "/apipie"
  config.validate                = false
  # where is your API defined?
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/api/**/*.rb"
end
