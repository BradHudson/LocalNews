class AddYahooTokenToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :yahoo_token, :string
    add_column :users, :yahoo_secret, :string
    add_column :users, :yahoo_league_id, :string
  end
end
