# OmniAuth-Douban-OAuth2
======================
This is the official OmniAuth strategy for authenticating to Douban. To use it, you'll need to sign up for an OAuth2 Application Key and Secret on the [Open Platform](https://www.douban.com/service/auth2/apikey/apply)


## Basic Usage

``` ruby
use OmniAuth::Builder do
  provider :douban, ENV['DOUBAN_KEY'], ENV['DOUBAN_SECRET']
end
```

## How to install

``` ruby
gem install omniauth-douban-oauth2
```

## Wiki

[Wiki](https://github.com/liluo/omniauth-douban-oauth2/wiki)
