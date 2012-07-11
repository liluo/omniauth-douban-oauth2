require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Douban < OmniAuth::Strategies::OAuth2
      option :name, 'douban'
      option :client_options, {
        :site          => 'https://api.douban.com',
        :authorize_url => 'https://www.douban.com/service/auth2/auth',
        :token_url     => 'https://www.douban.com/service/auth2/token'
      }

      option :token_params, {
        :parse => :json,
      }

      uid do
        raw_info['id']
      end

      info do
        {
          :nickname    => raw_info['uid'],
          :name        => raw_info['screen_name'],
          :city        => raw_info['city'],
          :location    => raw_info['location'],
          :description => raw_info['description'],

          :douban      => {
            :url          => raw_info['url'],
            :created_at   => raw_info['created_at'],
            :large_avatar => raw_info['large_avatar']
          }
        }
      end

      extra do
        { :raw_info => raw_info }
      end

      def raw_info
        access_token.options[:param_name] = 'access_token'
        @raw_info ||= access_token.get('/shuo/users/@me').parsed
      rescue ::Timeout::Error => e
        raise e
      end

    end
  end
end

OmniAuth.config.add_camelization 'douban', 'Douban'
