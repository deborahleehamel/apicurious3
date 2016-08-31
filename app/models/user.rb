class User < ApplicationRecord

  def self.from_omniauth(auth, access_token)
  where(uid: auth[:uid]).first_or_create do |new_user|
    require "pry"; binding.pry
    new_user.uid      = auth["id"]
    new_user.name     = auth["name"]
    new_user.username = auth["login"]
    new_user.avatar   = auth["avatar_url"]
    new_user.token    = access_token
  end
end
end
