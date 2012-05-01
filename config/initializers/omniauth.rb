Rails.application.config.middleware.use OmniAuth::Builder do
  provider :cas, :host=>"https://auth.vt.edu"
end

