require 'services/times_service'
require 'oauth2'
require 'base64'
class HomeController < ApplicationController
  def index
    yahoo
  end

  def form
  end

  def search
    @results = Services::Times.article_search(params)
  end

  def yahoo
    client_id = ENV['YAHOO_CLIENT_ID']
    client_secret = ENV['YAHOO_CLIENT_SECRET']
    oauth_client = OAuth2::Client.new(client_id, client_secret, {
        site: 'https://api.login.yahoo.com',
        authorize_url: '/oauth2/request_auth',
        token_url: '/oauth2/get_token',
    })

    auth = "Basic #{Base64.strict_encode64("#{client_id}:#{client_secret}")}"

    #REFRESH TOKEN GET
    new_token = oauth_client.get_token({
                                           redirect_uri: 'https://localnews-staging.herokuapp.com/',
                                           refresh_token: 'ADwx9VdQsu77ZJWJoocCetsA21nF8i8oC7Mw4I9_av4fxYTkC3__TyD2Dc5aVEo-',
                                           grant_type: 'refresh_token',
                                           headers: { 'Authorization' => auth } })
    puts new_token

    @result = HTTParty.get("https://fantasysports.yahooapis.com/fantasy/v2/league/359.l.101698/scoreboard;week=4", headers: { Authorization: "Bearer #{ new_token.token }" })
  end

  private

  def autocomplete(params)
    @params = params
    base_url = 'https://maps.googleapis.com/maps/api/place/autocomplete/json'
    input = 'Vict'
    types = 'cities'

    @result = HTTParty.get("#{ base_url }?input=#{ input }&types=(#{ types })&language=en_US&key=#{ ENV['PLACES_API_KEY'] }")
  end
end