class Api::Textpair::Request
  attr_accessor :query

  def initialize(text1, text2)
    @query = {
      app_id: ENV['GOO_LABS_APP_ID'],
      text1: text1,
      text2: text2
    }
  end

  def request
    client = HTTPClient.new
    header = {
      'Content-Type' => 'application/json'
    }
    request = client.post(ENV['GOO_LABS_TEXTPAIR_URI'], body: @query.to_json, header: header)
    request
  end
end