class HomeController < ApplicationController
  def index
  end

  def form
  end

  private

  def autocomplete
    base_url = 'https://maps.googleapis.com/maps/api/place/autocomplete/json'
    input = 'Vict'
    types = 'cities'

    HTTParty.get("#{ base_url }?input=#{ input }&types=(#{ types })&language=en_US&key=#{ ENV['PLACES_API_KEY'] }")
  end
end