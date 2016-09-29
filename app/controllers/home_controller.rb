require 'services/times_service'
class HomeController < ApplicationController
  def index
  end

  def form
  end

  def search
    @results = Services::Times.article_search(params)
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