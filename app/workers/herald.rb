class Herald < SimpleWorker::Base

  attr_accessor :post_back_url, :subscription_ids

  def run
    uri = URI.parse(post_back_url)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.request_uri, initheader = {'Content-Type' => 'application/json'})
    request.body = subscription_ids.to_json
    puts "posting back to #{uri.request_uri} with body: #{request.body}"
    response = http.request(request)
  end
  
end
