module OmniAuth
  module Strategies
    class Babili < OmniAuth::Strategies::OAuth2
      option :name, :babili

      option :client_options, {
        site: Rails.application.secrets.provider_site,
        authorize_path: '/oauth/authorize'
      }

      uid do
        raw_info["id"]
      end

      info do
        {name: raw_info["name"]}
      end

      def raw_info
        @raw_info ||= access_token.get('/api/user').parsed
      end
    end
  end
end