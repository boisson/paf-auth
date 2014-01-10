# Change this omniauth configuration to point to your registered provider
# Since this is a registered application, add the app id and secret here
require 'proteste_auth_id'

APP_ID      = '<%= @random_app_id %>'
APP_SECRET  = '<%= @random_app_secret %>'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :proteste_auth_id, APP_ID, APP_SECRET
end