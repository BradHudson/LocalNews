require 'httparty'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  def index
    render json: autocomplete
  end

  private

  def autocomplete
    base_url = 'https://maps.googleapis.com/maps/api/place/autocomplete/json'
    input = 'Vict'
    types = 'cities'

    HTTParty.get("#{ base_url }?input=#{ input }&types=(#{ types })&language=en_US&key=#{ ENV['PLACES_API_KEY'] }")
  end
end
