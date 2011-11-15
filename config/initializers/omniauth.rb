Rails.application.config.middleware.use OmniAuth::Builder do
  provider :cas, :server=>"https://auth.vt.edu", :cas_server=>"https://auth.vt.edu"
end

