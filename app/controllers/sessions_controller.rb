class SessionsController < ApplicationController

  def GoogleAuth
    omniauth_data = request.env['omniauth.auth']
    user = User.from_google_omniauth(omniauth_data)

    session[:user_id] = user.id
    session[:token] = omniauth_data[:credentials][:token]
    
    redirect_to dashboard_path
  end
end
