Rails.application.config.middleware.use OmniAuth::Builder do
  provider :yahoo_oauth2, ENV['YAHOO_CLIENT_ID'], ENV['YAHOO_CLIENT_SECRET'],
           name: 'yahoo'
end