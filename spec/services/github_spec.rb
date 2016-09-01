require "rails_helper"

RSpec.describe "the GithubService", type: :request do

  before(:each) do
    @current_user = User.create(
      uid: 1,
      name: "Deborah Hamel",
      username: "deborahleehamel",
      avatar: "picture",
      token: ENV["TEST_TOKEN"]
    )
  end

  it "returns the user's followers" do
    VCR.use_cassette("users_followers") do
      service = GithubService.new(@current_user).followers
      expect(service.count).to eq 16
    end
  end

  it "returns the user's starred repos" do
    VCR.use_cassette("starred") do
      service = GithubService.new(@current_user).starred
      expect(service.count).to eq 3
    end
  end

  it "returns users the user is following" do
    VCR.use_cassette("following") do
      service = GithubService.new(@current_user).following
      expect(service.count).to eq 12
    end
  end

  it "returns the user's repos" do
    VCR.use_cassette("user_repos") do
      service = GithubService.new(@current_user).repos
      expect(service.count).to eq 30
    end
  end

  xit "returns organizations the user is a part of" do
    VCR.use_cassette("user_organizations") do
      service = GithubService.new(@current_user).orgs
      expect(service.count).to eq 1
    end
  end

end
