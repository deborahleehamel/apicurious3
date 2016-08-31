class SessionsController < ApplicationController

  def create
    if params[:code]

      connection = Faraday.new(:url => 'https://github.com') do |faraday|
        faraday.request  :url_encoded
        faraday.response :logger
        faraday.adapter  Faraday.default_adapter
      end

      response = connection.post '/login/oauth/access_token', { :code => params[:code],
                                                     client_id: "2bbfad8f7128c8c22cbf",
                                                     client_secret: "9e67b17fa3475dc693c73711da86caa5dbe342e6" }

                                                     access_token = parse_access_token(response.body)

      new_connection = Faraday.new(:url => 'https://api.github.com') do |faraday|
        faraday.request  :url_encoded
        faraday.response :logger
        faraday.adapter  Faraday.default_adapter
      end

      response = new_connection.get '/user', { :access_token => access_token }
      auth = JSON.parse(response.body)

    if user = User.from_omniauth(auth, access_token)
      session[:user_id] = user.id
      redirect_to user_path(user.username)
    else
    redirect_to root_path
    end

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
