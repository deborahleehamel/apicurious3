class GithubHandshakeService

  def initialize(code)
    @code = code
  end

  def access_token
    connection = request_connection("https://github.com")
    response = connection.post '/login/oauth/access_token', { :code => @code,
                                                   client_id: "2bbfad8f7128c8c22cbf",
                                                   client_secret: "9e67b17fa3475dc693c73711da86caa5dbe342e6" }

    parse_access_token(response.body)
  end

  def auth(access_token)
    new_connection = request_connection("https://api.github.com")

    response = new_connection.get '/user', { :access_token => access_token }
    auth = JSON.parse(response.body).merge("token" => access_token)
  end

  private

  def request_connection(url)
    Faraday.new(:url => "#{url}") do |faraday|
      faraday.request  :url_encoded
      faraday.response :logger
      faraday.adapter  Faraday.default_adapter
    end
  end

  def parse_access_token(body)
    if /access_token=(.+)&scope/.match(body)
      $1
    end
  end

end
