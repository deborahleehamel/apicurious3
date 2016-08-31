class SessionsController < ApplicationController

  def create
    if params[:code]

      connection = Faraday.new(:url => 'https://github.com') do |faraday|
        faraday.request  :url_encoded
        faraday.response :logger
        faraday.adapter  Faraday.default_adapter
      end

    response = connection.post '/login/oauth/access_token', { :code => params[:code], client_id: "95da052db24b0ebbcf72", client_secret: "1e6bd76da887f691a0316233191c77ce7f62b0cc" } # POST "name=maguro" to http://sushi.com/nigiri
    #this gets us the access token for the client app

    access_token = parse_access_token(response.body)

    new_connection = Faraday.new(:url => 'https://api.github.com') do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
    require "pry"; binding.pry
    auth = new_connection.get '/user', { :access_token => access_token }

    # if user = User.from_omniauth(auth, token)
    #   session[:user_id] = user.id
    #   redirect_to user_path(user.username)
    # else
    # redirect_to root_path
    # end
  end
  end

  def destroy
    session.clear
    redirect_to root_path
  end

  private

  def parse_access_token(body)
    if /access_token=(.+)&scope/.match(body)
      $1
    end
  end
end
