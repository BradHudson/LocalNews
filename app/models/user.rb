class User < ApplicationRecord
  def self.from_omniauth(auth)
    user = User.where(users: auth.slice("provider", "uid")).first || create_from_omniauth(auth)
    user = update_token_info(user, auth) if user.twitter_token.nil? || user.twitter_secret.nil?
    user
  end

  def self.create_from_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.name = auth['info']['nickname']
      user.twitter_token = auth['credentials']['token']
      user.twitter_secret = auth['credentials']['secret']
    end
  end

  def self.update_token_info(user, auth)
    user.twitter_token = auth['credentials']['token']
    user.twitter_secret = auth['credentials']['secret']
    user.save!
    user
  end
end
