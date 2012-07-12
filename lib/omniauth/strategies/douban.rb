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
          :uid         => raw_info['uid'],
          :name        => raw_info['name'],
          :loc         => raw_info['loc'],
          :avatar      => raw_info['avatar'],
          :url         => raw_info['alt'],
          :desc        => raw_info['desc'],
          :status      => raw_info['status'],
          :created     => raw_info['created']
        }
      end

      extra do
        { :raw_info => raw_info }
      end

      def raw_info
        access_token.options[:param_name] = 'access_token'
        user_id = access_token.get('/shuo/users/@me').parsed['uid']
        @raw_info ||= access_token.get("/v2/people/#{ user_id }").parsed
      rescue ::Timeout::Error => e
        raise e
      end

    end
  end
end

OmniAuth.config.add_camelization 'douban', 'Douban'
