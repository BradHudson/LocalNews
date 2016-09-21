module Services
  class Times
    class << self
      def article_search(params)
        uri = URI("https://api.nytimes.com/svc/search/v2/articlesearch.json")
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        uri.query = URI.encode_www_form({
                                            "api-key" => ENV['TIMES_KEY'],
                                            "q" => build_search(params)
                                        })
        request = Net::HTTP::Get.new(uri.request_uri)
        @result = JSON.parse(http.request(request).body)
      end

      def build_search(params)
        "#{ params['city'] }, #{ params['state'] }"
      end
    end
  end
end
