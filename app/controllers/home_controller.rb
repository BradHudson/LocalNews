require 'services/times_service'
require 'oauth2'
require 'base64'
class HomeController < ApplicationController
  def index
    yahoo
    #comment in when ready to tweet
    #current_user.tweet('testing the tweets',current_user)
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

    #with twitter using http://127.0.0.1:3000/ as the callback works. maybe try here?
    #REFRESH TOKEN GET
    new_token = oauth_client.get_token({
                                           redirect_uri: 'https://localnews-staging.herokuapp.com/',
                                           refresh_token: 'ADwx9VdQsu77ZJWJoocCetsA21nF8i8oC7Mw4I9_av4fxYTkC3__TyD2Dc5aVEo-',
                                           grant_type: 'refresh_token',
                                           headers: { 'Authorization' => auth } })
    #OAUTH TOKEN GET
    # binding.pry
    # new_token = oauth_client.get_token({
    #                                        redirect_uri: 'https://localnews-staging.herokuapp.com/',
    #                                        code: 'abcdef',
    #                                        grant_type: 'authorization_code',
    #                                        headers: { 'Authorization' => auth } })
    puts new_token

    @result = HTTParty.get("https://fantasysports.yahooapis.com/fantasy/v2/league/359.l.101698/scoreboard;week=5", headers: { Authorization: "Bearer #{ new_token.token }" })
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