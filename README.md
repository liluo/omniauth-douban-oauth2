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

## Auth Hash

Here's an example *Auth Hash* available in `request.env['omniauth.auth']`:

```ruby
{
       "provider" => "douban",
            "uid" => "2217855",
           "info" => {
             "uid" => "xiaosong",
            "name" => "小松其实还没有",
          "loc_id" => "118371",
        "loc_name" => "陕西西安",
          "avatar" => "http://img3.douban.com/icon/u2217855-34.jpg",
             "alt" => "http://www.douban.com/people/xiaosong/",
            "desc" => "你确实知道就必须证明",
         "created" => "2008-02-05 15:26:44"
    },
    "credentials" => {
                "token" => "6516f0d........", # OAuth 2.0 access_token
        "refresh_token" => "30c8c560..........", # OAuth 2.0 refresh_token
           "expires_at" => 1357053699,        # when the access token expires (it always will)
              "expires" => true               # this will always be true
    },
          "extra" => {
        "raw_info" => {
               "loc_id" => "118371",
                 "name" => "小松其实还没有",
              "created" => "2008-02-05 15:26:44",
             "loc_name" => "陕西西安",
               "avatar" => "http://img3.douban.com/icon/u2217855-34.jpg",
            "signature" => "啊我要增肥...",
                  "uid" => "xiaosong",
                  "alt" => "http://www.douban.com/people/xiaosong/",
                   "id" => "2217855",
                 "desc" => "你确实知道就必须证明"
        }
    }
}
```
