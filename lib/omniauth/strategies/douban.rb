require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class DoubanOAuth2 < OmniAuth::Strategies::OAuth2
      options :client_options, {
        :site          => 'https://api.douban.com',
        :authorize_url => 'https://www.douban.com/service/auth2/auth',
        :token_url     => 'https://www.douban.com/service/auth2/token'
      }

#      uid do
#        raw_info['id']
#      end
#
#      info do
#        {
#          :nickname    => raw_info['db:uid']['$t'],
#          :name        => raw_info['title']['$t']
#          :location    => raw_info['location'] ? raw_info['location']['$t'] : nil,
#          :image       => raw_info['link'].find{ |l| l['@rel'] == 'icon' }['@href'],
#          :description => raw_info['content']['$t'],
#          :urls        => {
#            'Douban' => raw_info['link'].find{ |l| l['@rel'] == 'alternate' }['@href']
#          }
#        }
#      end
#
#      extra do
#        { :raw_info => raw_info }
#      end
#
#      def raw_info
#        access_token.options[:mode]       = :query
#        access_token.options[:param_name] = 'access_token'
#        @raw_info ||= access_token.get('/people/%40me?alt=json').body
#      rescue ::Errno::ETIMEDOUT
#        raise ::Timeout::Error
#      end

    end
  end
end

OmniAuth.config.add_camelization 'douban', 'Douban'
