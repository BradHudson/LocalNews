class SessionsController < ApplicationController
  def create
    binding.pry
    @user = User.from_omniauth(auth_hash)
    binding.pry
    session[:user_id] = @user.id
    redirect_to '/', notice: 'Signed In!'
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/', notice: 'Signed Out!'
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end