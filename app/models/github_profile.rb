class GithubProfile < OpenStruct
  attr_reader :service

  # def initialize(attrs)
  #   @name
  # end
  # def initialize(user)
  #   @user = user
  # end

  def self.service(current_user)
     @service ||= GithubService.new(current_user)
  end

  def self.followers(current_user)
     service(current_user).followers.map { |github_profile| GithubProfile.new(github_profile)}
  end

  def self.starred(current_user)
    service(current_user).starred.map { |github_profile| GithubProfile.new(github_profile)}
  end

  def self.following(current_user)
    service(current_user).following.map { |github_profile| GithubProfile.new(github_profile)}
  end

  def self.repos(current_user)
    service(current_user).repos.map { |github_profile| GithubProfile.new(github_profile)}
  end

  def self.orgs(current_user)
    service(current_user).orgs.map { |github_profile| GithubProfile.new(github_profile)}
  end
end

# class GithubOrganizations
#   def self.find_all(user)
#     service(current_user).orgs.map { |github_profile| GithubProfile.new(github_profile)}
#   end
# end
#
#
# class GithubUser
#   def initialize(attr)
#     @user = attr[:user]
#   end
#
#   def self.following(user)
#     service(user).following.map do |github_user|
#       GithubUser.new(github_user)
#     end
#   end
#
#   def self.followers(current_user)
#      service(current_user).followers.map { |github_profile| GithubProfile.new(github_profile)}
#   end
#
#   def self.service(user)
#      @service ||= GithubService.new(user)
#   end
# end
