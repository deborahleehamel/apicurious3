class UsersController < ApplicationController

  def show
    # @presenter = UsersShowPresenter.new(current_user)

    @service = GithubService.new(current_user)
    @followers = GithubProfile.followers(current_user)
    @starred = GithubProfile.starred(current_user)
    @following = GithubProfile.following(current_user)
    @repos = GithubProfile.repos(current_user)
    @orgs = GithubProfile.orgs(current_user)
  end

end

# class UsersShowPresenter
#   def initialize(user)
#     @user = user
#   end
#
#   def followers
#     @followers ||= GithubProfile.followers(current_user)
#   end
# end

# in the view
# <%= @presenter.
