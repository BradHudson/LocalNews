class User < ApplicationRecord
  def self.from_omniauth(auth)
    User.where(users: auth.slice("provider"), users: auth.slice("uid")).first || create_from_omniauth(auth)
  end

  def self.create_from_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.name = auth['info']['nickname']
    end
  end
end
