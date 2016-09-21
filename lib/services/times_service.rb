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
        modify_response(JSON.parse(http.request(request).body)['response']['docs'])
      end

      def build_search(params)
        "#{ params.fetch('city','') }, #{ params.fetch('state','') }"
      end

      def modify_response(response)
        return_hash = []
        response.each do |i|
          return_hash.push(
           {
               web_url: i['web_url'],
               snippet: i['snippet'],
               headline: i['headline']['print_headline']
           }
          )
        end
        return_hash
      end
    end
  end
end
