# OmniAuth-Douban-OAuth2
======================
This is the OmniAuth strategy for authenticating to Douban. To use it, you'll need to sign up for an OAuth2 Application Key and Secret on the [Open Platform](https://www.douban.com/service/auth2/apikey/apply)


## How to install

``` ruby
gem install omniauth-douban-oauth2
```

## Basic Usage

``` ruby
use OmniAuth::Builder do
  provider :douban, ENV['DOUBAN_KEY'], ENV['DOUBAN_SECRET']
end
```

## Example with Sinatra

``` ruby
require 'sinatra'
require 'omniauth-douban-oauth2'

KEY = 'your api key'
SECRET = 'your api secret'

use Rack::Session::Cookie

use OmniAuth::Builder do
  provider :douban, KEY, SECRET
end 

get '/' do
   '<a href="/auth/douban">Douban</a>' 
end

get '/auth/douban/callback' do
  auth = env['omniauth.auth']
  auth.to_hash.to_s
end

get '/auth/failure' do
  'auth failure'
end

```
