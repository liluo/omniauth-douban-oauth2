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
        raw_info['id'].split('/').last
      end

      info do
        {
          :name        => raw_info['title'],
          :nickname    => raw_info['uid'],
          :signature   => raw_info['signature'],
          :content     => raw_info['content'],
          :location    => raw_info['location'] ? raw_info['location']['__content__'] : nil,
          :links       => {
            :self      => raw_info['link'].find{ |l| l['rel'] == 'self' }['href'],
            :icon      => raw_info['link'].find{ |l| l['rel'] == 'icon' }['href'], 
            :douban    => raw_info['link'].find{ |l| l['rel'] == 'alternate' }['href'],
          }
        }
      end

      extra do
        { :raw_info => raw_info }
      end

      def raw_info
        access_token.options[:param_name] = 'access_token'
        @raw_info ||= access_token.get('/people/51789002').parsed['entry']
      rescue ::Timeout::Error => e
        raise e
      end

    end
  end
end

OmniAuth.config.add_camelization 'douban', 'Douban'
