class User < ApplicationRecord
  def self.from_omniauth(auth)
    binding.pry
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

  def tweet(tweet, user)
    binding.pry
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_KEY']
      config.consumer_secret     = ENV['TWITTER_SECRET']
      binding.pry
      config.access_token        = user.twitter_token
      config.access_token_secret = user.twitter_secret
    end

    client.update(tweet)
  end
end
