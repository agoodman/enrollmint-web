class Courier < ActiveRecord::Base

  validates_presence_of :post_back_url, :subscription_id
  
  def perform
    uri = URI.parse(post_back_url)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.request_uri, initheader = {'Content-Type' => 'application/json'})
    request.body = [subscription_id].to_json
    puts "posting back to #{uri.request_uri} with body: #{request.body}"
    response = http.request(request)
    destroy
  end

end
