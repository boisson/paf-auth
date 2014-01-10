require 'omniauth-oauth2'
module OmniAuth
  module Strategies
    class ProtesteAuthId < OmniAuth::Strategies::OAuth2

      PROTESTE_AUTH_PROVIDER_URL = "#{Rails.application.config.acccess_control_2_url}" rescue "http://localhost:3000"
      
      option :client_options, {
        :site =>  PROTESTE_AUTH_PROVIDER_URL,
        :authorize_url => "#{PROTESTE_AUTH_PROVIDER_URL}/auth/proteste_auth_id/authorize",
        :access_token_url => "#{PROTESTE_AUTH_PROVIDER_URL}/auth/proteste_auth_id/access_token"
      }

      uid  { raw_info['id'] }
      info { raw_info['info'] }

      def raw_info
        @raw_info ||= access_token.get("/auth/proteste_auth_id/user.json?oauth_token=#{access_token.token}").parsed
      end
    end
  end
end
