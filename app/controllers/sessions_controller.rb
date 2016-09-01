class SessionsController < ApplicationController

  def create
    if params[:code]
      gh = GithubHandshakeService.new(params[:code])
      if user = User.from_debauth(gh.auth(gh.access_token))
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

end
