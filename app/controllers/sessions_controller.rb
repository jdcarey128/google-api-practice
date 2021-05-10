class SessionsController < ApplicationController

  def GoogleAuth
    require 'pry'; binding.pry
    access_token = request.env['omniauth.auth']
    # use access token info to find user 
    # add user info to session data 
    # save google token
    redirect_to dashboard_path
  end
end
