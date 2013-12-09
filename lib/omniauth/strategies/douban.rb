require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Douban < OmniAuth::Strategies::OAuth2
      DEFAULT_SCOPE = 'douban_basic_common,shuo_basic_r,shuo_basic_w'

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
          :name        => raw_info['name'],
          :nickname    => raw_info['uid'],
          :location    => raw_info['loc_name'],
          :image       => raw_info['avatar'],
          :urls        => {:alt => raw_info['alt']},
          :description => raw_info['desc'],
        }
      end

      extra do
        { :raw_info => raw_info }
      end

      def raw_info
        access_token.options[:param_name] = 'access_token'
        @raw_info ||= access_token.get("/v2/user/~me").parsed
      rescue ::Timeout::Error => e
        raise e
      end

      def authorize_params
        super.tap do |params|
          params[:scope] = request.params['scope'] || params[:scope] || DEFAULT_SCOPE
        end
      end

    end
  end
end

OmniAuth.config.add_camelization 'douban', 'Douban'
