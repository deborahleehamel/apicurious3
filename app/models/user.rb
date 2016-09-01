class User < ApplicationRecord

  def self.from_debauth(auth)
    where(uid: auth["id"]).first_or_create do |new_user|
      new_user.uid      = auth["id"]
      new_user.name     = auth["name"]
      new_user.username = auth["login"]
      new_user.avatar   = auth["avatar_url"]
      new_user.token    = auth["token"]
    end
  end

end
