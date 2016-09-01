class GithubProfile < OpenStruct
  attr_reader :service

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
